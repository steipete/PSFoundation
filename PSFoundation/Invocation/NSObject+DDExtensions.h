//
//  NSObject+DDExtensions.h
//  PSFoundation
//
//  Copyright 2009 Dave Dribin.
//  Licensed under MIT.  All rights reserved.
//

@interface NSObject (PSThreadProxy)

- (NSProxy *)invokeOnMainThread;
- (NSProxy *)invokeOnMainThreadAndWaitUntilDone:(BOOL)waitUntilDone;

- (NSProxy *)invokeOnThread:(NSThread *)thread;
- (NSProxy *)invokeOnThread:(NSThread *)thread waitUntilDone:(BOOL)waitUntilDone;

@end