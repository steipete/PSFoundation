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
+ (NSString *)keyForAddress:(in_addr_t) addr;
- (NetworkStatus)_localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags;
- (NetworkStatus)_networkStatusForFlags:(SCNetworkReachabilityFlags)flags;
@end

NSString* const kReachabilityChangedNotification = @"SCNetworkReachabilityChangedNotification";

#define kShouldPrintReachabilityFlags 0

static void PrintReachabilityFlags(SCNetworkReachabilityFlags    flags, const char* comment)
{
#if kShouldPrintReachabilityFlags
    
    DDLogInfo(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
              (flags & kSCNetworkReachabilityFlagsIsWWAN)				  ? 'W' : '-',
              (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
              
              (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
              (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
              (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
              (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
              (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
              (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
              (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-',
              comment
              );
#endif
}

@implementation Reachability

- (void)dealloc {
    [self stopNotifier];
    if (reachabilityRef) {
		CFRelease(reachabilityRef);
        reachabilityRef = NULL;
    }
    [super dealloc];
}

- (Reachability *)initWithReachabilityRef:(SCNetworkReachabilityRef)ref {
    return [self initWithReachabilityRef:ref isWiFi:NO];
}

- (Reachability *)initWithReachabilityRef:(SCNetworkReachabilityRef)ref isWiFi:(BOOL)wifi {
    if ((self = [super init])) {
        reachabilityRef = ref;
        localWiFiRef = wifi;
    }
    return self;
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) {
#pragma unused(target, flags)
    NSCAssert(info, @"info was NULL in Reachability callback!");
    BOOL classCheck = [(NSObject*) info isKindOfClass: [Reachability class]];
    NSCAssert(classCheck, @"info was the WRONG CLASS in Reachability callback!");
    
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    Reachability *theInfo = (Reachability *)info;
    [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification object:theInfo];
    [pool release];
}

+ (Reachability *)reachabilityWithHostName:(NSString *)hostName {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability) {
        return [[[self alloc] initWithReachabilityRef:reachability isWiFi:NO] autorelease];
    }
    return nil;
}

+ (Reachability *)reachabilityWithAddress:(const struct sockaddr_in*)hostAddress {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(NULL, (const struct sockaddr*)hostAddress);
    if (reachability) {
        return [[[self alloc] initWithReachabilityRef:reachability isWiFi:NO] autorelease];
    }
    return nil;
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
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(NULL, (const struct sockaddr*)&localWiFi);
    
    if (reachability) {
        return [[[self alloc] initWithReachabilityRef:reachability isWiFi:YES] autorelease];
    }
    
    return nil;
}

- (BOOL)startNotifier {
    SCNetworkReachabilityContext context = {0, self, NULL, NULL, NULL};
    if (SCNetworkReachabilitySetCallback(reachabilityRef, ReachabilityCallback, &context)) {
        if (SCNetworkReachabilityScheduleWithRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)) {
            return YES;
        }
    }
    return NO;
}

- (void)stopNotifier {
	if(reachabilityRef) {
		SCNetworkReachabilityUnscheduleFromRunLoop(reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}    
}

- (NetworkStatus)currentReachabilityStatus {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    NetworkStatus retVal = NotReachable;
    SCNetworkReachabilityFlags flags = 0;
    
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
        if (localWiFiRef)
            retVal = [self _localWiFiStatusForFlags:flags];
        else
            retVal = [self _networkStatusForFlags:flags];
    }
    
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
    
    SCNetworkReachabilityFlags flags = 0;
    
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
        return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
                (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic | kSCNetworkReachabilityFlagsConnectionOnDemand));
    }
    
    return NO;
}

- (BOOL) isInterventionRequired {
    NSAssert(reachabilityRef, @"currentReachabilityStatus not initialized property.");
    
    SCNetworkReachabilityFlags flags = 0;
    
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags)) {
        return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
                (flags & kSCNetworkReachabilityFlagsInterventionRequired));
    }
    
    return NO;
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

+ (NSString *)keyForAddress:(in_addr_t) addr {
    // addr is assumed to be in network byte order.
    
    static const int       highShift    = 24;
    static const int       highMidShift = 16;
    static const int       lowMidShift  =  8;
    static const in_addr_t mask         = 0x000000ff;
    
    addr = ntohl(addr);
    
    return [NSString stringWithFormat: @"%d.%d.%d.%d", 
            (addr >> highShift)    & mask, 
            (addr >> highMidShift) & mask, 
            (addr >> lowMidShift)  & mask, 
            addr                  & mask];
}

- (NetworkStatus)_localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags {
    PrintReachabilityFlags(flags, "localWiFiStatusForFlags");
    
    NetworkStatus retVal = NotReachable;
    
    if((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
        retVal = ReachableViaWiFi;
    
    return retVal;
}

- (NetworkStatus)_networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    
    if (!(flags & kSCNetworkReachabilityFlagsReachable))
        return NotReachable;
    
    NetworkStatus retVal = NotReachable;
    
    if (!(flags & kSCNetworkReachabilityFlagsConnectionRequired))
        retVal = ReachableViaWiFi;
    
    IF_3_2_OR_GREATER(
                      if (!(flags & kSCNetworkReachabilityFlagsConnectionOnDemand) || !(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)) {
                          if (!(flags & kSCNetworkReachabilityFlagsInterventionRequired))
                              retVal = ReachableViaWiFi;
                      }
                      )
    
    IF_IOS(
           if (flags & kSCNetworkReachabilityFlagsIsWWAN)
           retVal = ReachableViaWWAN;
           )
    
    return retVal;
}

@end