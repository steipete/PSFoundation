//
//  PSMacros+Geometry.h
//  PSFoundation
//

#ifndef PS_HAS_ARC
#define PS_HAS_ARC __has_feature(objc_arc)
#define PS_HAS_WEAK_ARC __has_feature(objc_arc_weak)

#if PS_HAS_ARC
    #define PS_RETAIN(o) o
    #define PS_DO_RETAIN(o)
    #define PS_AUTORELEASE(o) o
    #define PS_DO_AUTORELEASE(o)
    #define PS_DEALLOC()
    #define PS_DEALLOC_NIL(o) 
    #define PS_RELEASE(x)
    #define PS_RELEASE_NIL(x) x = nil
    #define PS_RELEASE_VIEW_NIL(x) [x removeFromSuperview], x = nil

    #define PS_AUTORELEASEPOOL(...) @autoreleasepool { do {__VA_ARGS__;} while(0); }
    #define PS_SET_RETAINED(var, val) var = val
    #define PS_SET_COPIED(var, val) var = [val copy]

    #if PS_HAS_WEAK_ARC
    #define __ps_weak __weak
    #else
    #define __ps_weak __unsafe_unretained
    #endif
    #define ps_weak weak
    #define ps_strong strong

    #define ps_retainedObject objc_retainedObject
    #define ps_unretainedObject objc_unretainedObject
    #define ps_unretainedPointer objc_unretainedPointer
#else
    #define PS_RETAIN(o) [o retain]
    #define PS_DO_RETAIN(o) [o retain]
    #define PS_AUTORELEASE(o) [o autorelease]
    #define PS_DO_AUTORELEASE(o) [o autorelease]
    #define PS_DEALLOC() [super dealloc]
    #define PS_DEALLOC_NIL(o) o = nil
    #if DEBUG
    #define PS_RELEASE(x) do { [x release]; } while (0);
    #else
    #define PS_RELEASE(x) [x release], x = nil
    #endif
    #define PS_RELEASE_NIL(x) [x release], x = nil
    #define PS_RELEASE_VIEW_NIL(x) do { [x removeFromSuperview], [x release], x = nil; } while (0)

    #define PS_AUTORELEASEPOOL(...) NSAutoreleasePool *pool = [NSAutoreleasePool new]; do {__VA_ARGS__;} while(0); [pool drain]
    #define PS_SET_RETAINED(var, val) { \
    if (var) \
    [var release]; \
    var = [val retain]; \
    }
    #define PS_SET_COPIED(var, val) { \
    if (var) \
    [var release]; \
    var = [val copy]; \
    }

    define __ps_weak
    #define __unsafe_unretained
    #define __strong
    #define __weak
    #define ps_weak assign
    #define ps_strong retain

    typedef const void* objc_objectptr_t;
    static __inline NS_RETURNS_RETAINED id __ps_objc_retainedObject(objc_objectptr_t CF_CONSUMED pointer) { return (id)pointer; }
    static __inline NS_RETURNS_NOT_RETAINED id __ps_objc_unretainedObject(objc_objectptr_t pointer) { return (id)pointer; }
    static __inline CF_RETURNS_NOT_RETAINED void *__ps_objc_unretainedPointer(id object) { return (void *)object; }
    #define ps_retainedObject __ps_objc_retainedObject
    #define ps_unretainedObject __ps_objc_unretainedObject
    #define ps_unretainedPointer __ps_objc_unretainedPointer
#endif

#endif