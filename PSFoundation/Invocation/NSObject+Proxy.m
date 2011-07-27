//
//  NSObject+Proxy.m
//  PSFoundation
//
//  Includes code by the following:
//   - Corey Floyd.
//   - Steve Degutis.
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


@implementation NSObject (SDStuff)

- (id) nextRunloopProxy {
	return [[[SDNextRunloopProxy alloc] initWithTarget:self] autorelease];
}

- (id) proxyWithDelay:(float)time {
	return [[[FJSDelayProxy alloc] initWithTarget:self delay:time] autorelease];
}

@end
