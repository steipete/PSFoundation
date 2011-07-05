//
// Reachability.m
// PSFoundation
//
//  Includes code by the following:
//   - Apple Inc.         2010.  Apple Sample.
//   - Andrew Donoho.     2009.  BSD.
//   - Matthias Tretter.  2011.
//

#import "Reachability.h"

@interface Reachability ()
- (id)initWithReachability:(SCNetworkReachabilityRef)ref;
- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags;
@end

NSString* const kReachabilityChangedNotification = @"SCNetworkReachabilityChangedNotification";

@implementation Reachability

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) {
    NSCAssert(info, @"info was NULL in Reachability callback!");
    Reachability *infoObject = (__bridge id)info;
    BOOL classCheck = [infoObject isKindOfClass:[Reachability class]];
    NSCAssert(classCheck, @"info was the WRONG CLASS in Reachability callback!");
    
    PS_AUTORELEASEPOOL([[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:infoObject]);
}

- (void)dealloc {
    [self stopNotifier];
    
    if (reachabilityRef)
		CFRelease(reachabilityRef);
    
    PS_DEALLOC();
}

- (Reachability *)initWithReachability:(SCNetworkReachabilityRef)ref {
    if ((self = [super init])) {
        reachabilityRef = ref;
    }
    return self;
}

+ (Reachability *)reachabilityWithHostName:(NSString *)hostName {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    
    if (!reachability)
        return nil;
    
    return PS_AUTORELEASE([[self alloc] initWithReachability:reachability]);
}

+ (Reachability *)reachabilityWithAddress:(const struct sockaddr_in*)hostAddress {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(NULL, (const struct sockaddr*)hostAddress);
    
    if (!reachability)
        return nil;
    
    return PS_AUTORELEASE([[self alloc] initWithReachability:reachability]);
}

+ (Reachability *)reachabilityForInternetConnection {
    struct sockaddr_in zero;
    bzero(&zero, sizeof(zero));
    zero.sin_len = sizeof(zero);
    zero.sin_family = AF_INET;
    return [self reachabilityWithAddress:&zero];
}

+ (Reachability *)reachabilityForLocalWiFi {
    struct sockaddr_in localWiFi;
    bzero(&localWiFi, sizeof(localWiFi));
    localWiFi.sin_len = sizeof(localWiFi);
    localWiFi.sin_family = AF_INET;
    localWiFi.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    
    return [self reachabilityWithAddress:&localWiFi];
}

- (BOOL)startNotifier {
    SCNetworkReachabilityContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    if (SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback, &context))
        if (SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
            return YES;
    return NO;
}

- (void)stopNotifier {
	if (reachabilityRef)
		SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
}

- (NetworkStatus)currentReachabilityStatus {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    SCNetworkReachabilityFlags flags = 0;
    
    if (!(flags & kSCNetworkReachabilityFlagsReachable))
        return NotReachable;
    
    NetworkStatus retVal = NotReachable;
    
    if (!(flags & kSCNetworkReachabilityFlagsConnectionOnDemand) || !(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)) {
        if (!(flags & kSCNetworkReachabilityFlagsInterventionRequired))
                retVal = ReachableViaWiFi;
    }
    
    IF_IOS(
        if (flags & kSCNetworkReachabilityFlagsIsWWAN)
           retVal = ReachableViaWWAN;
    )
    
    return retVal;
}

- (BOOL)isConnectionRequired {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    SCNetworkReachabilityFlags flags = 0;
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    return NO;
}

- (BOOL)connectionRequired {
    return [self isConnectionRequired];
}

- (BOOL) isReachable {
    return (self.status != NotReachable);
}

- (BOOL) isConnectionOnDemand {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    
    SCNetworkReachabilityFlags flags = self.flags;
    return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) && (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic | kSCNetworkReachabilityFlagsConnectionOnDemand));
}

- (BOOL) isInterventionRequired {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    
    SCNetworkReachabilityFlags flags = self.flags;
    return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) && (flags & kSCNetworkReachabilityFlagsInterventionRequired));
}

- (BOOL) isReachableViaWWAN {
    return (self.flags == ReachableViaWWAN);
}

- (BOOL) isReachableViaWiFi {
    return (self.flags == ReachableViaWiFi);
}

- (SCNetworkReachabilityFlags)reachabilityFlags {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    
    SCNetworkReachabilityFlags flags = 0;
    
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
        return flags;
    }
    
    return 0;
}

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
    if (!(flags & kSCNetworkReachabilityFlagsReachable))
        return NotReachable;
    
    NetworkStatus retVal = NotReachable;
    
    if (!(flags & kSCNetworkReachabilityFlagsConnectionOnDemand) || !(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)) {
        if (!(flags & kSCNetworkReachabilityFlagsInterventionRequired))
            retVal = ReachableViaWiFi;
    }
    
    IF_IOS(
        if (flags & kSCNetworkReachabilityFlagsIsWWAN)
           retVal = ReachableViaWWAN;
    )
    
    return retVal;
}

@end