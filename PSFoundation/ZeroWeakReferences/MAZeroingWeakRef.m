//
//  MAZeroingWeakRef.m
//  ZeroingWeakRef
//
//  Created by Michael Ash on 7/5/10.
//

#import "MAZeroingWeakRef.h"

#import <dlfcn.h>
#import <libkern/OSAtomic.h>
#import <objc/runtime.h>
#import <mach/mach.h>
#import <mach/port.h>
#import <pthread.h>


/*
 The COREFOUNDATION_HACK_LEVEL macro allows you to control how much horrible CF
 hackery is enabled. The following levels are defined:
 
 3 - Completely insane hackery allows weak references to CF objects, deallocates
 them asynchronously in another thread to eliminate resurrection-related race
 condition and crash.
 
 2 - Full hackery allows weak references to CF objects by doing horrible
 things with the private CF class table. Extremely small risk of resurrection-
 related race condition leading to a crash.
 
 1 - Mild hackery allows foolproof identification of CF objects and will assert
 if trying to make a ZWR to one.
 
 0 - No hackery, checks for an "NSCF" prefix in the class name to identify CF
 objects and will assert if trying to make a ZWR to one
 */
#define COREFOUNDATION_HACK_LEVEL 0

/*
 The KVO_HACK_LEVEL macro allows similar control over the amount of KVO hackery.
 
 1 - Use the private _isKVOA method to check for a KVO dynamic subclass.
 
 0 - No hackery, uses the KVO overridden -class to check.
 */
#define KVO_HACK_LEVEL 0

#if KVO_HACK_LEVEL >= 1
@interface NSObject (KVOPrivateMethod)

- (BOOL)_isKVOA;

@end
#endif


@interface MAZeroingWeakRef ()

- (void)_zeroTarget;
- (void)_executeCleanupBlockWithTarget: (id)target;

@end


@implementation MAZeroingWeakRef

#if COREFOUNDATION_HACK_LEVEL >= 2

typedef struct __CFRuntimeClass {	// Version 0 struct
    CFIndex version;
    const char *className;
    void (*init)(CFTypeRef cf);
    CFTypeRef (*copy)(CFAllocatorRef allocator, CFTypeRef cf);
    void (*finalize)(CFTypeRef cf);
    Boolean (*equal)(CFTypeRef cf1, CFTypeRef cf2);
    CFHashCode (*hash)(CFTypeRef cf);
    CFStringRef (*copyFormattingDesc)(CFTypeRef cf, CFDictionaryRef formatOptions);	// str with retain
    CFStringRef (*copyDebugDesc)(CFTypeRef cf);	// str with retain
    void (*reclaim)(CFTypeRef cf);
} CFRuntimeClass;

extern CFRuntimeClass * _CFRuntimeGetClassWithTypeID(CFTypeID typeID);

typedef void (*CFFinalizeFptr)(CFTypeRef);
static CFFinalizeFptr *gCFOriginalFinalizes;
static size_t gCFOriginalFinalizesSize;

#endif

#if COREFOUNDATION_HACK_LEVEL >= 1

extern Class *__CFRuntimeObjCClassTable;

#endif

static pthread_mutex_t gMutex;

static CFMutableDictionaryRef gObjectWeakRefsMap; // maps (non-retained) objects to CFMutableSetRefs containing weak refs

static NSMutableSet *gCustomSubclasses;
static NSMutableDictionary *gCustomSubclassMap; // maps regular classes to their custom subclasses

#if COREFOUNDATION_HACK_LEVEL >= 3
static CFMutableSetRef gCFWeakTargets;
static NSOperationQueue *gCFDelayedDestructionQueue;
#endif

+ (void)initialize
{
    if(self == [MAZeroingWeakRef class])
    {
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init(&mutexattr);
        pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&gMutex, &mutexattr);
        pthread_mutexattr_destroy(&mutexattr);
        
        gObjectWeakRefsMap = CFDictionaryCreateMutable(NULL, 0, NULL, &kCFTypeDictionaryValueCallBacks);
        gCustomSubclasses = [[NSMutableSet alloc] init];
        gCustomSubclassMap = [[NSMutableDictionary alloc] init];
        
#if COREFOUNDATION_HACK_LEVEL >= 3
        gCFWeakTargets = CFSetCreateMutable(NULL, 0, NULL);
        gCFDelayedDestructionQueue = [[NSOperationQueue alloc] init];
#endif
    }
}

#define USE_BLOCKS_BASED_LOCKING 1
#if USE_BLOCKS_BASED_LOCKING
#define BLOCK_QUALIFIER __block
static void WhileLocked(void (^block)(void))
{
    pthread_mutex_lock(&gMutex);
    block();
    pthread_mutex_unlock(&gMutex);
}
#define WhileLocked(block) WhileLocked(^block)
#else
#define BLOCK_QUALIFIER
#define WhileLocked(block) do { \
        pthread_mutex_lock(&gMutex); \
        block \
        pthread_mutex_unlock(&gMutex); \
    } while(0)
#endif

static void AddWeakRefToObject(id obj, MAZeroingWeakRef *ref)
{
    CFMutableSetRef set = (void *)CFDictionaryGetValue(gObjectWeakRefsMap, obj);
    if(!set)
    {
        set = CFSetCreateMutable(NULL, 0, NULL);
        CFDictionarySetValue(gObjectWeakRefsMap, obj, set);
        CFRelease(set);
    }
    CFSetAddValue(set, ref);
}

static void RemoveWeakRefFromObject(id obj, MAZeroingWeakRef *ref)
{
    CFMutableSetRef set = (void *)CFDictionaryGetValue(gObjectWeakRefsMap, obj);
    CFSetRemoveValue(set, ref);
}

static void ClearWeakRefsForObject(id obj)
{
    CFMutableSetRef set = (void *)CFDictionaryGetValue(gObjectWeakRefsMap, obj);
    if(set)
    {
        NSSet *setCopy = [[NSSet alloc] initWithSet: (NSSet *)set];
        [setCopy makeObjectsPerformSelector: @selector(_zeroTarget)];
        [setCopy makeObjectsPerformSelector: @selector(_executeCleanupBlockWithTarget:) withObject: obj];
        [setCopy release];
        CFDictionaryRemoveValue(gObjectWeakRefsMap, obj);
    }
}

static Class GetCustomSubclass(id obj)
{
    Class class = object_getClass(obj);
    while(class && ![gCustomSubclasses containsObject: class])
        class = class_getSuperclass(class);
    return class;
}

static Class GetRealSuperclass(id obj)
{
    Class class = GetCustomSubclass(obj);
    NSCAssert(class, @"Coudn't find ZeroingWeakRef subclass in hierarchy starting from %@, should never happen", object_getClass(obj));
    return class_getSuperclass(class);
}

static void CustomSubclassRelease(id self, SEL _cmd)
{
    Class superclass = GetRealSuperclass(self);
    IMP superRelease = class_getMethodImplementation(superclass, @selector(release));
    WhileLocked({
        ((void (*)(id, SEL))superRelease)(self, _cmd);
    });
}

static void CustomSubclassDealloc(id self, SEL _cmd)
{
    ClearWeakRefsForObject(self);
    Class superclass = GetRealSuperclass(self);
    IMP superDealloc = class_getMethodImplementation(superclass, @selector(dealloc));
    ((void (*)(id, SEL))superDealloc)(self, _cmd);
}

static Class CustomSubclassClassForCoder(id self, SEL _cmd)
{
    Class class = GetCustomSubclass(self);
    Class superclass = class_getSuperclass(class);
    IMP superClassForCoder = class_getMethodImplementation(superclass, @selector(classForCoder));
    Class classForCoder = ((id (*)(id, SEL))superClassForCoder)(self, _cmd);
    if(classForCoder == class)
        classForCoder = superclass;
    return classForCoder;
}

#if COREFOUNDATION_HACK_LEVEL >= 3

static void CallCFReleaseLater(CFTypeRef cf)
{
    mach_port_t thread = mach_thread_self(); // must "release" this
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    SEL sel = @selector(releaseLater:fromThread:);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: [MAZeroingWeakRef methodSignatureForSelector: sel]];
    [inv setTarget: [MAZeroingWeakRef class]];
    [inv setSelector: sel];
    [inv setArgument: &cf atIndex: 2];
    [inv setArgument: &thread atIndex: 3];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithInvocation: inv];
    [gCFDelayedDestructionQueue addOperation: op];
    [op release];
    [pool release];
}

static const void *kPCThreadExited = &kPCThreadExited;
static const void *kPCError = NULL;

static const void *GetPC(mach_port_t thread)
{
#if defined(__x86_64__)
    x86_thread_state64_t state;
    unsigned int count = x86_THREAD_STATE64_COUNT;
    thread_state_flavor_t flavor = x86_THREAD_STATE64;
#define PC_REGISTER __rip
#elif defined(__i386__)
    i386_thread_state_t state;
    unsigned int count = i386_THREAD_STATE_COUNT;
    thread_state_flavor_t flavor = i386_THREAD_STATE;
#define PC_REGISTER __eip
#elif defined(__arm__)
    arm_thread_state_t state;
    unsigned int count = ARM_THREAD_STATE_COUNT;
    thread_state_flavor_t flavor = ARM_THREAD_STATE;
#define PC_REGISTER __pc
#elif defined(__ppc__)
    ppc_thread_state_t state;
    unsigned int count = PPC_THREAD_STATE_COUNT;
    thread_state_flavor_t flavor = PPC_THREAD_STATE;
#define PC_REGISTER __srr0
#elif defined(__ppc64__)
    ppc_thread_state64_t state;
    unsigned int count = PPC_THREAD_STATE64_COUNT;
    thread_state_flavor_t flavor = PPC_THREAD_STATE64;
#define PC_REGISTER __srr0
#else
#error don't know how to get PC for the current architecture!
#endif
    
    kern_return_t ret = thread_get_state(thread, flavor, (thread_state_t)&state, &count);
    if(ret == KERN_SUCCESS)
        return (void *)state.PC_REGISTER;
    else if(ret == KERN_INVALID_ARGUMENT)
        return kPCThreadExited;
    else
        return kPCError;
}

static void CustomCFFinalize(CFTypeRef cf)
{
    WhileLocked({
        if(CFSetContainsValue(gCFWeakTargets, cf))
        {
            if(CFGetRetainCount(cf) == 1)
            {
                ClearWeakRefsForObject((id)cf);
                CFSetRemoveValue(gCFWeakTargets, cf);
                CFRetain(cf);
                CallCFReleaseLater(cf);
            }
        }
        else
        {
            void (*fptr)(CFTypeRef) = gCFOriginalFinalizes[CFGetTypeID(cf)];
            if(fptr)
                fptr(cf);
        }
    });
}

#elif COREFOUNDATION_HACK_LEVEL >= 2

static void CustomCFFinalize(CFTypeRef cf)
{
    WhileLocked({
        if(CFGetRetainCount(cf) == 1)
        {
            ClearWeakRefsForObject((id)cf);
            void (*fptr)(CFTypeRef) = gCFOriginalFinalizes[CFGetTypeID(cf)];
            if(fptr)
                fptr(cf);
        }
    });
}
#endif

static BOOL IsTollFreeBridged(Class class, id obj)
{
#if COREFOUNDATION_HACK_LEVEL >= 1
    CFTypeID typeID = CFGetTypeID(obj);
    Class tfbClass = __CFRuntimeObjCClassTable[typeID];
    return class == tfbClass;
#else
    return [NSStringFromClass(class) hasPrefix: @"NSCF"];
#endif
}

#if COREFOUNDATION_HACK_LEVEL >= 3
void _CFRelease(CFTypeRef cf);

+ (void)releaseLater: (CFTypeRef)cf fromThread: (mach_port_t)thread
{
    BOOL retry = YES;
    
    while(retry)
    {
        BLOCK_QUALIFIER const void *pc;
        // ensure that the PC is outside our inner code when fetching it,
        // so we don't have to check for all the nested calls
        WhileLocked({
            pc = GetPC(thread);
        });
        
        if(pc != kPCError)
        {
            if(pc == kPCThreadExited || pc < (void *)CustomCFFinalize || pc > (void *)IsTollFreeBridged)
            {
                Dl_info info;
                int success = dladdr(pc, &info);
                if(success)
                {
                    if(info.dli_saddr != _CFRelease)
                    {
                        retry = NO; // success!
                        CFRelease(cf);
                        mach_port_mod_refs(mach_task_self(), thread, MACH_PORT_RIGHT_SEND, -1 ); // "release"
                    }
                }
            }
        }
    }
}
#endif

static BOOL IsKVOSubclass(id obj)
{
#if KVO_HACK_LEVEL >= 1
    return [obj respondsToSelector: @selector(_isKVOA)] && [obj _isKVOA];
#else
    return [obj class] == class_getSuperclass(object_getClass(obj));
#endif
}

static Class CreatePlainCustomSubclass(Class class)
{
    NSString *newName = [NSString stringWithFormat: @"%s_MAZeroingWeakRefSubclass", class_getName(class)];
    const char *newNameC = [newName UTF8String];
    
    Class subclass = objc_allocateClassPair(class, newNameC, 0);
    
    Method release = class_getInstanceMethod(class, @selector(release));
    Method dealloc = class_getInstanceMethod(class, @selector(dealloc));
    Method classForCoder = class_getInstanceMethod(class, @selector(classForCoder));
    class_addMethod(subclass, @selector(release), (IMP)CustomSubclassRelease, method_getTypeEncoding(release));
    class_addMethod(subclass, @selector(dealloc), (IMP)CustomSubclassDealloc, method_getTypeEncoding(dealloc));
    class_addMethod(subclass, @selector(classForCoder), (IMP)CustomSubclassClassForCoder, method_getTypeEncoding(classForCoder));
    
    objc_registerClassPair(subclass);
    
    return subclass;
}

#ifdef __clang__
#pragma clang diagnostic push
#endif
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
static void SetSuperclass(Class class, Class newSuper)
{
    class_setSuperclass(class, newSuper);
}
#ifdef __clang__
#pragma clang diagnostic pop
#endif

static void RegisterCustomSubclass(Class subclass, Class superclass)
{
    [gCustomSubclassMap setObject: subclass forKey: superclass];
    [gCustomSubclasses addObject: subclass];
}

static Class CreateCustomSubclass(Class class, id obj)
{
    if(IsTollFreeBridged(class, obj))
    {
#if COREFOUNDATION_HACK_LEVEL >= 2
        CFTypeID typeID = CFGetTypeID(obj);
        CFRuntimeClass *cfclass = _CFRuntimeGetClassWithTypeID(typeID);
        
        if(typeID >= gCFOriginalFinalizesSize)
        {
            gCFOriginalFinalizesSize = typeID + 1;
            gCFOriginalFinalizes = realloc(gCFOriginalFinalizes, gCFOriginalFinalizesSize * sizeof(*gCFOriginalFinalizes));
        }
        
        do {
            gCFOriginalFinalizes[typeID] = cfclass->finalize;
        } while(!OSAtomicCompareAndSwapPtrBarrier(gCFOriginalFinalizes[typeID], CustomCFFinalize, (void *)&cfclass->finalize));
#else
        NSCAssert(0, @"Cannot create zeroing weak reference to object of type %@ with COREFOUNDATION_HACK_LEVEL set to %d", class, COREFOUNDATION_HACK_LEVEL);
#endif
        return class;
    }
    else
    {
        Class classToSubclass = class;
        Class newClass = nil;
        BOOL isKVO = IsKVOSubclass(obj);
        if(isKVO)
        {
            classToSubclass = class_getSuperclass(class);
            newClass = [gCustomSubclassMap objectForKey: classToSubclass];
        }
        
        if(!newClass)
        {
            newClass = CreatePlainCustomSubclass(classToSubclass);
            if(isKVO)
            {
                SetSuperclass(class, newClass); // EVIL EVIL EVIL
                
                // if you thought setting the superclass was evil, wait until you get a load of this
                // for some reason, KVO stores the superclass of the KVO class in the class's indexed ivars
                // I don't know why they don't just use class_getSuperclass, but there we are
                // this has to be set as well, otherwise KVO can skip over our dealloc, causing
                // weak references not to get zeroed, doh!
                id *kvoSuperclass = object_getIndexedIvars(class);
                *kvoSuperclass = newClass;
                
                RegisterCustomSubclass(newClass, classToSubclass);
            }
        }
        
        return newClass;
    }
}

static void EnsureCustomSubclass(id obj)
{
    if(!GetCustomSubclass(obj))
    {
        Class class = object_getClass(obj);
        Class subclass = [gCustomSubclassMap objectForKey: class];
        if(!subclass)
        {
            subclass = CreateCustomSubclass(class, obj);
            RegisterCustomSubclass(subclass, class);
        }
        
        // only set the class if the current one is its superclass
        // otherwise it's possible that it returns something farther up in the hierarchy
        // and so there's no need to set it then
        if(class_getSuperclass(subclass) == class)
            object_setClass(obj, subclass);
    }
}

static void RegisterRef(MAZeroingWeakRef *ref, id target)
{
    WhileLocked({
        EnsureCustomSubclass(target);
        AddWeakRefToObject(target, ref);
#if COREFOUNDATION_HACK_LEVEL >= 3
        if(IsTollFreeBridged(object_getClass(target), target))
            CFSetAddValue(gCFWeakTargets, target);
#endif
    });
}

static void UnregisterRef(MAZeroingWeakRef *ref)
{
    WhileLocked({
        id target = ref->_target;
        
        if(target)
            RemoveWeakRefFromObject(target, ref);
    });
}

+ (BOOL)canRefCoreFoundationObjects
{
    return COREFOUNDATION_HACK_LEVEL >= 2;
}

+ (id)refWithTarget: (id)target
{
    return [[[self alloc] initWithTarget: target] autorelease];
}

- (id)initWithTarget: (id)target
{
    if((self = [self init]))
    {
        _target = target;
        RegisterRef(self, target);
    }
    return self;
}

- (void)dealloc
{
    UnregisterRef(self);
#if NS_BLOCKS_AVAILABLE
    [_cleanupBlock release];
#endif
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"<%@: %p -> %@>", [self class], self, [self target]];
}

#if NS_BLOCKS_AVAILABLE
- (void)setCleanupBlock: (void (^)(id target))block
{
    block = [block copy];
    [_cleanupBlock release];
    _cleanupBlock = block;
}
#endif

- (id)target
{
    BLOCK_QUALIFIER id ret;
    WhileLocked({
        ret = [_target retain];
    });
    return [ret autorelease];
}

- (void)_zeroTarget
{
    _target = nil;
}

- (void)_executeCleanupBlockWithTarget: (id)target
{
#if NS_BLOCKS_AVAILABLE
    if(_cleanupBlock)
    {
        _cleanupBlock(target);
        [_cleanupBlock release];
        _cleanupBlock = nil;
    }
#endif
}

@end
