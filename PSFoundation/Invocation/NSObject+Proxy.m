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

@interface SDNextRunloopProxy : NSObject {
	id target;
	NSInvocation *invocation;
}

@end

@implementation SDNextRunloopProxy

- (id) initWithTarget:(id)newTarget {
	if ((self = [super init])) {
        PS_SET_RETAINED(target, newTarget);
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    PS_SET_RETAINED(invocation, anInvocation);
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorAtNextRunloop) withObject:nil afterDelay:0.0];
}

- (void) performSelectorAtNextRunloop {
	[invocation invokeWithTarget:target];
    
    PS_RELEASE(target);
    PS_RELEASE(invocation);
    PS_RELEASE(self);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [target methodSignatureForSelector:aSelector];
}

@end

/****************************************************************************/


@interface FJSDelayProxy : NSObject {
	id target;
	NSInvocation *invocation;
	float delay;
}

@end

@implementation FJSDelayProxy

- (id) initWithTarget:(id)newTarget delay:(float)time{
	if ((self = [super init])) {
        PS_SET_RETAINED(target, newTarget);
		delay = time;
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    PS_SET_RETAINED(invocation, anInvocation);
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorWithDelay) withObject:nil afterDelay:delay];
}

- (void) performSelectorWithDelay {
	[invocation invokeWithTarget:target];
    
    PS_RELEASE(target);
    PS_RELEASE(invocation);
    PS_RELEASE(self);
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
	PS_SET_RETAINED(realObject, newRealObject);
	return self;
}

- (void) dealloc {
    PS_RELEASE(realObject);
	PS_DEALLOC();
}

- (void) finalize {
    PS_RELEASE_NIL(realObject);
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
	return [[SDNextRunloopProxy alloc] initWithTarget:self];
}

- (id) proxyWithDelay:(float)time {
	return [[FJSDelayProxy alloc] initWithTarget:self delay:time];
}

- (id) performOnMainThreadProxy {
    return PS_AUTORELEASE([[PRHMainThreadPerformingProxy alloc] initWithRealObject:self]);
}
@end
