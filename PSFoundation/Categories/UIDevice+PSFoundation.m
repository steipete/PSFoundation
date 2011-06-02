//
//  UIDevice+PSFoundation.m
//  PSFoundation
//
//  Created by Shaun Harrison on 12/11/08.
//  Licensed under MIT.  Copyright 2008 enormego.
//

#import "UIDevice+PSFoundation.h"
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (Helper)

+ (NSString *)debugInfo {
  NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
  NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
  NSString *appShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]; 
#ifdef DEBUG
  // adds this special string for better bug mail filtering
  appVersion = [NSString stringWithFormat:@"%@ - Debug", appVersion];
#endif
  NSString *iphoneOSVersion = [[UIDevice currentDevice] systemVersion];
  NSString *deviceType = [[UIDevice currentDevice] platform];
  if ([[UIDevice currentDevice] isJailbroken]) {
    deviceType = [NSString stringWithFormat:@"%@ - Jailbroken", deviceType];
  }
  NSString *deviceUUID = [[UIDevice currentDevice] uniqueIdentifier];
  NSString *deviceLang = [[NSLocale preferredLanguages] objectAtIndex:0];
  return [NSString stringWithFormat:@"%@ %@ %@\niOS: %@\nDevice: %@\nUUID: %@\nLang: %@", appName, appVersion, (appShortVersion ? appShortVersion : @""), iphoneOSVersion, deviceType, deviceUUID, deviceLang];
}

// http://blog.zachwaugh.com/post/309927273/programmatically-retrieving-ip-address-of-iphone
+ (NSString *)ipAddress {
  NSString *address = @"error";
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;

  // retrieve the current interfaces - returns 0 on success
  success = getifaddrs(&interfaces);
  if (success == 0)
  {
    // Loop through linked list of interfaces
    temp_addr = interfaces;
    while(temp_addr != NULL)
    {
      if(temp_addr->ifa_addr->sa_family == AF_INET)
      {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
        {
          // Get NSString from C String
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
        }
      }

      temp_addr = temp_addr->ifa_next;
    }
  }

  // Free memory
  freeifaddrs(interfaces);

  return address;
}

- (double)availableMemory {
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);

	if(kernReturn != KERN_SUCCESS) {
		return NSNotFound;
	}

	return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G
 iPod1,1   -> iPod touch 1G
 iPod2,1   -> iPod touch 2G
 */

// http://stackoverflow.com/questions/1108859/detect-the-specific-iphone-ipod-touch-model
- (NSString *)platform {
  size_t size;
  sysctlbyname("hw.machine", NULL, &size, NULL, 0);
  char *machine = malloc(size);
  sysctlbyname("hw.machine", machine, &size, NULL, 0);
  NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
  free(machine);
  return platform;
}

- (BOOL)isSlowDevice {
  // determine if we should load images while scrolling
  NSString *hardwareModel = [[UIDevice currentDevice] platform];

  // slow devices: 1st Gen iPod, iPhone, 3G iPhone
  BOOL isSlowDevice = [hardwareModel isEqualToString:@"iPhone1,1"]  || [hardwareModel isEqualToString:@"iPhone1,2"]  || [hardwareModel isEqualToString:@"iPod1,1"];
  return isSlowDevice;
}


- (BOOL)isJailbroken {
    // TODO:  Some jailbroken devices may not have Cydia installed (if you're in the future, maybe even ATV)
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";

    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }

    return jailbroken;
}

- (BOOL)isTablet {
    IF_3_2_OR_GREATER(
        return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    );
    return NO;
}

@end
