
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
		target = [newTarget retain];
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	invocation = [anInvocation retain];
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorAtNextRunloop) withObject:nil afterDelay:0.0];
}

- (void) performSelectorAtNextRunloop {
	[invocation invokeWithTarget:target];
	[target release];
	[invocation release];
	[self release];
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
		target = [newTarget retain];
		delay = time;
	}
	return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	invocation = [anInvocation retain];
	[invocation retainArguments];
	[self performSelector:@selector(performSelectorWithDelay) withObject:nil afterDelay:delay];
}

- (void) performSelectorWithDelay {
	[invocation invokeWithTarget:target];
	[target release];
	[invocation release];
	[self release];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [target methodSignatureForSelector:aSelector];
}

@end

/****************************************************************************/

@interface PRHMainThreadPerformingProxy : NSProxy
{
	id realObject;
}

- (id) initWithRealObject:(id)newRealObject;

@end

@implementation PRHMainThreadPerformingProxy

- (id) initWithRealObject:(id)newRealObject {
	//This is a direct subclass of NSProxy, so no super message!
	realObject = [newRealObject retain];
	return self;
}
- (void) dealloc {
	[realObject release];
	[super dealloc];
}
- (void) finalize {
	realObject = nil;
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

- (id) proxyWithDelay:(float)time{
	
	return [[FJSDelayProxy alloc] initWithTarget:self delay:time];
}

- (id) performOnMainThreadProxy {
	return [[[PRHMainThreadPerformingProxy alloc] initWithRealObject:self] autorelease];
}
@end
