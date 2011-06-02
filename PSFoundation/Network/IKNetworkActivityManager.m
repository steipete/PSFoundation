//
//  IKNetworkActivityManager.m
//  PSFoundation
//
//  Includes code by the following:
//   - Ilya Kulakov.       2010.
//   - Zachary Waldowski.  2011.  MIT.
//

#import "IKNetworkActivityManager.h"

@implementation IKNetworkActivityManager

SYNTHESIZE_SINGLETON_FOR_CLASS(IKNetworkActivityManager)

- (IKNetworkActivityManager *)init {
    return [self initWithCapacity:0];
}

- (IKNetworkActivityManager *)initWithCapacity:(NSInteger)capacity {
    if ((self = [super init])) {
        if (capacity > 0)
            users = [[NSMutableSet alloc] initWithCapacity:capacity];
        else
            users = [[NSMutableSet alloc] init];
        count = 0;
    }
    return self;
}

- (void)dealloc {
    [users release];
    [super dealloc];
}


- (void)addNetworkUser:(id)aUser {
    @synchronized (self) {
        [users addObject:aUser];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}


- (void)removeNetworkUser:(id)aUser {
    @synchronized (self) {
        [users removeObject:aUser];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = (users.count > 0 || count > 0);
    }
}


- (void)removeAllNetworkUsers {
    @synchronized (self) {
        [users removeAllObjects];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)incrementNetworkUsage {
    @synchronized (self) {
        count++;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)decrementNetworkUsage {
    @synchronized (self) {
        count--;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = (users.count > 0 || count > 0);
    }
}

@end