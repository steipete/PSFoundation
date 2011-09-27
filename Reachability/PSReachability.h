//
//  PSReachability.h
//  WhereTU
//
//  Created by Tretter Matthias on 25.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

// we define our own notification to be more independent of Reachability
#define kPSReachabilityChangedNotification  @"kPSReachabilityChangedNotification"
#define kPSNetworkStatusKey                 @"kPSNetworkStatusKey"


/** Protocol for ViewController that are configured to use Reachability */
@protocol PSReachabilityAware <NSObject>

@optional
- (void)configureForNetworkStatus:(NSNotification *)notification;

@end

/** Reachabilty Singleton instance */
@interface PSReachability : NSObject {
    Reachability *reachability_;
    NetworkStatus currentNetworkStatus_;
    
    NSString *hostAddress_;
    NSDate *lastReachabilityChange_;
}

@property (nonatomic, retain, readonly) Reachability *reachability;
@property (nonatomic, assign, readonly) NetworkStatus currentNetworkStatus;
@property (nonatomic, copy, readonly) NSString *hostAddress;

+ (PSReachability *)sharedPSReachability;

- (void)startCheckingHostAddress:(NSString *)hostAddress;

- (void)setupReachabilityFor:(id)object;
- (void)setupReachabilityFor:(id)object sendInitialNotification:(BOOL)sendInitialNotification;
- (void)shutdownReachabilityFor:(id)object;

@end
