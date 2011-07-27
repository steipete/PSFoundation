//
//  NSObject+DDExtensions.m
//  PSFoundation
//
//  Copyright 2009 Dave Dribin.
//  Licensed under MIT.  All rights reserved.
//

#import "NSObject+DDExtensions.h"
#import "DDInvocationGrabber.h"

@implementation NSObject (PSThreadProxy)

- (NSProxy *)invokeOnMainThread {
    return [self invokeOnMainThreadAndWaitUntilDone:NO];
}

- (NSProxy *)invokeOnMainThreadAndWaitUntilDone:(BOOL)waitUntilDone {
    DDInvocationGrabber * grabber = [DDInvocationGrabber invocationGrabber];
    [grabber setForwardInvokesOnMainThread:YES];
    [grabber setWaitUntilDone:waitUntilDone];
    return [grabber prepareWithInvocationTarget:self];
}

- (NSProxy *)invokeOnThread:(NSThread *)thread {
    return [self invokeOnThread:thread waitUntilDone:NO];
}

- (NSProxy *)invokeOnThread:(NSThread *)thread waitUntilDone:(BOOL)waitUntilDone {
    DDInvocationGrabber * grabber = [DDInvocationGrabber invocationGrabber];
    [grabber setInvokesOnThread:thread];
    [grabber setWaitUntilDone:waitUntilDone];
    return [grabber prepareWithInvocationTarget:self];
}

@end
