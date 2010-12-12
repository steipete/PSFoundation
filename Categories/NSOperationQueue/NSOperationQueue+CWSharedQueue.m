//
//  NSOperationQueue+CWSharedQueue.m
//
//  Created by Fredrik Olsson on 2008-10-28.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NSOperationQueue+CWSharedQueue.h"


@implementation NSOperationQueue (CWSharedQueue)

static NSOperationQueue* cw_sharedOperationQueue = nil;

+(NSOperationQueue*)sharedOperationQueue;
{
	if (cw_sharedOperationQueue == nil) {
    cw_sharedOperationQueue = [[NSOperationQueue alloc] init];
    [cw_sharedOperationQueue setMaxConcurrentOperationCount:CW_DEFAULT_OPERATION_COUNT];
  }
  return cw_sharedOperationQueue;
}

+(void)setSharedOperationQueue:(NSOperationQueue*)operationQueue;
{
	if (operationQueue != cw_sharedOperationQueue) {
  	[cw_sharedOperationQueue release];
    cw_sharedOperationQueue = [operationQueue retain];
  }
}

@end


@implementation NSObject (CWSharedQueue)

-(NSInvocationOperation*)performSelectorInBackgroundQueue:(SEL)aSelector withObject:(id)arg;
{
	NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:aSelector object:arg];
  [[NSOperationQueue sharedOperationQueue] addOperation:operation];
	return [operation autorelease];  
}

-(NSInvocationOperation*)performSelectorInBackgroundQueue:(SEL)aSelector withObject:(id)arg dependencies:(NSArray *)dependencies priority:(NSOperationQueuePriority)priority;
{
	NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:aSelector object:arg];
  [operation setQueuePriority:priority];
  for (NSOperation* dependency in dependencies) {
   	[operation addDependency:dependency]; 
  }
  [[NSOperationQueue sharedOperationQueue] addOperation:operation];
	return [operation autorelease];  
}

@end
