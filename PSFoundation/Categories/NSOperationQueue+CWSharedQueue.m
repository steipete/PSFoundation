//
//  NSOperationQueue+CWSharedQueue.m
//  PSFoundation
//
//  Created by Fredrik Olsson on 10/28/2008.
//  Licensed in the public domain.  All rights reserved.
//

#import "NSOperationQueue+CWSharedQueue.h"

@implementation NSOperationQueue (CWSharedQueue)

static __strong NSOperationQueue* cw_sharedOperationQueue = nil;

+ (NSOperationQueue*)sharedOperationQueue {
	if (!cw_sharedOperationQueue) {
        cw_sharedOperationQueue = [NSOperationQueue new];
        [cw_sharedOperationQueue setMaxConcurrentOperationCount:CW_DEFAULT_OPERATION_COUNT];
    }
    return cw_sharedOperationQueue;
}

+ (void)setSharedOperationQueue:(NSOperationQueue*)operationQueue {
    if ([operationQueue isEqual:cw_sharedOperationQueue])
        PS_SET_RETAINED(cw_sharedOperationQueue, operationQueue);
}

@end


@implementation NSObject (CWSharedQueue)

- (NSInvocationOperation *)performSelectorInBackgroundQueue:(SEL)aSelector withObject:(id)arg {
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:aSelector object:arg];
    [[NSOperationQueue sharedOperationQueue] addOperation:operation];
	return PS_AUTORELEASE(operation);
}

- (NSInvocationOperation *)performSelectorInBackgroundQueue:(SEL)aSelector withObject:(id)arg dependencies:(NSArray *)dependencies priority:(NSOperationQueuePriority)priority {
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:aSelector object:arg];
    [operation setQueuePriority:priority];
    for (NSOperation* dependency in dependencies) {
        [operation addDependency:dependency]; 
    }
    [[NSOperationQueue sharedOperationQueue] addOperation:operation];
	return PS_AUTORELEASE(operation);
}

@end
