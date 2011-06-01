//
//  UIDeviceHelper.m
//  CocoaHelpers
//
//  Created by Shaun Harrison on 12/11/08.
//  Copyright (c) 2008-2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIDeviceHelper.h"
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (Helper)

+ (NSString *)debugInfo {
  NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
  NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
  NSString *appShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]; 
#ifndef APPSTORE
  // adds this special string for better bug mail filtering
  appVersion = [NSString stringWithFormat:@"%@ AdHoc", appVersion];
#endif
  NSString *iphoneOSVersion = [[UIDevice currentDevice] systemVersion];
  NSString *deviceType = [[UIDevice currentDevice] platform];
  if ([[UIDevice currentDevice] isJailbroken]) {
    deviceType = [NSString stringWithFormat:@"%@ JB", deviceType];
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

@end
