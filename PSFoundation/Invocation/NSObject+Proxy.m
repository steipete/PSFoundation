//
//  NSObject+Proxy.m
//  PSFoundation
//
//  Includes code by the following:
//   - Corey Floyd.
//   - Steve Degutis.
//   - Peter Hosey.
//

#import "NSObject+Proxy.h"

/****************************************************************************/

@interface SDNextRunloopProxy : NSObject

@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSInvocation *invocation;

@end

@implementation SDNextRunloopProxy

@synthesize target, invocation;

- (id) initWithTarget:(id)newTarget {
	if ((self = [super init])) {
        self.target = newTarget;
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    self.invocation = anInvocation;
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorAtNextRunloop) withObject:nil afterDelay:0.0];
}

- (void) performSelectorAtNextRunloop {
	[invocation invokeWithTarget:target];
    
    self.target = nil;
    self.invocation = nil;
    [self release];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [target methodSignatureForSelector:aSelector];
}

@end

/****************************************************************************/


@interface FJSDelayProxy : NSObject

@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic, assign) NSTimeInterval delay;

@end

@implementation FJSDelayProxy

@synthesize target, invocation, delay;

- (id) initWithTarget:(id)newTarget delay:(float)time{
	if ((self = [super init])) {
        self.target = newTarget;
		self.delay = time;
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    self.invocation = anInvocation;
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorWithDelay) withObject:nil afterDelay:delay];
}

- (void) performSelectorWithDelay {
	[invocation invokeWithTarget:target];
    
    self.target = nil;
    self.invocation = nil;
    [self release];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [target methodSignatureForSelector:aSelector];
}

@end

/****************************************************************************/

@interface PRHMainThreadPerformingProxy : NSProxy {
	id realObject;
}

- (id)initWithRealObject:(id)newRealObject;

@end

@implementation PRHMainThreadPerformingProxy

- (id)initWithRealObject:(id)newRealObject {
    realObject = [newRealObject retain];
	return self;
}

- (void) dealloc {
    [realObject release];
    [super dealloc];
}

- (void) finalize {
    [realObject release];
	[super finalize];
}

- (void) forwardInvocation:(NSInvocation *)invocation {
	if (realObject) {
		[invocation setTarget:realObject];
		if (![invocation argumentsRetained])
			[invocation retainArguments];
		[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO];
	}
}

- (NSMethodSignature *) methodSignatureForSelector:(SEL)selector {
	return [realObject methodSignatureForSelector:selector];
}

@end


/****************************************************************************/


@implementation NSObject (SDStuff)

- (id) nextRunloopProxy {
	return [[[SDNextRunloopProxy alloc] initWithTarget:self] autorelease];
}

- (id) proxyWithDelay:(float)time {
	return [[[FJSDelayProxy alloc] initWithTarget:self delay:time] autorelease];
}

- (id) performOnMainThreadProxy {
    return [[[PRHMainThreadPerformingProxy alloc] initWithRealObject:self] autorelease];
}
@end
