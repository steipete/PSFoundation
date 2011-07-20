//
//  PSReachability.m
//  WhereTU
//
//  Created by Tretter Matthias on 25.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "PSReachability.h"
#import "PSFoundation.h"

@interface PSReachability ()

@property (nonatomic, retain, readwrite) Reachability *reachability;
@property (nonatomic, assign, readwrite) NetworkStatus currentNetworkStatus;
@property (nonatomic, copy, readwrite) NSString *hostAddress;

- (void)reachabilityChanged:(NSNotification *)note;

@end

@implementation PSReachability

SYNTHESIZE_SINGLETON_FOR_CLASS(PSReachability);

@synthesize reachability = reachability_;
@synthesize currentNetworkStatus = currentNetworkStatus_;
@synthesize hostAddress = hostAddress_;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [reachability_ stopNotifier];
    [reachability_ release];
    [hostAddress_ release];
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Reachability
////////////////////////////////////////////////////////////////////////

- (void)startCheckingHostAddress:(NSString *)hostAddress {
    self.hostAddress = hostAddress;
    
    // Listen for reachability changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityWithHostName:hostAddress];
    self.currentNetworkStatus = self.reachability.currentReachabilityStatus; 
    
    // start continous updates
    [self.reachability startNotifier];
}

- (void)setupReachabilityFor:(id)object {
    if ([object respondsToSelector:@selector(configureForNetworkStatus:)]) {
        // listen for PSReachability Notifications
        [[NSNotificationCenter defaultCenter] addObserver:object
                                                 selector:@selector(configureForNetworkStatus:)
                                                     name:kPSReachabilityChangedNotification
                                                   object:self];
        
        // perform initial setup
        NSNotification *notification = [NSNotification notificationWithName:kPSReachabilityChangedNotification 
                                                                     object:self 
                                                                   userInfo:XDICT($I(self.currentNetworkStatus),kPSNetworkStatusKey)];
        [object performSelector:@selector(configureForNetworkStatus:) withObject:notification];
        
        DDLogVerbose(@"Object %@ was setup to use PSReachability", object);
    } else {
        DDLogVerbose(@"Object %@ isn't configured to use PSReachability", object);
    }
}

- (void)shutdownReachabilityFor:(id)object {
    if ([object respondsToSelector:@selector(configureForNetworkStatus:)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:object name:kPSReachabilityChangedNotification object:self];
    }
}

- (void)reachabilityChanged:(NSNotification *)note {
    // get Reachability instance from notification
	Reachability* reachability = [note object];
    
	// get current status
	NetworkStatus newNetworkStatus = [reachability currentReachabilityStatus];
    
    // if network status has changed, post notification
    if (newNetworkStatus != self.currentNetworkStatus) {
        self.currentNetworkStatus = newNetworkStatus;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPSReachabilityChangedNotification
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:newNetworkStatus] 
                                                                                               forKey:kPSNetworkStatusKey]];
    }
}

@end
