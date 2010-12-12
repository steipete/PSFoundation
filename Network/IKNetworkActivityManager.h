//
//  IKNetworkActivityManager.h
//  IKNetworkActivityManager
//
//  Created by Ilya Kulakov on 14.08.10.
//  Copyright 2010. All rights reserved.

#import <Foundation/Foundation.h>


@interface IKNetworkActivityManager : NSObject {
    CFMutableSetRef networkUsers;
}

- (IKNetworkActivityManager *)initWithCapacity:(NSInteger)capacity;

- (void)addNetworkUser:(id)aUser;

- (void)removeNetworkUser:(id)aUser;

- (void)removeAllNetworkUsers;

@end


@interface IKNetworkActivityManager (Singleton)

+ (IKNetworkActivityManager *)sharedInstance;

@end
