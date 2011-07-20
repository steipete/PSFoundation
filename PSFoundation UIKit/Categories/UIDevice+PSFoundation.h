//
//  UIDevice+PSFoundation.h
//  PSFoundation
//
//  Created by Shaun Harrison on 12/11/08.
//  Licensed under MIT.  Copyright 2008 enormego.
//

@interface UIDevice (Helper)

// Available device memory in MB
@property(readonly) double availableMemory;

+ (NSString *)ipAddress;
+ (NSString *)debugInfo;

- (NSString *)platform;
- (BOOL)isSlowDevice;
- (BOOL)isJailbroken;
- (BOOL)isTablet;

@end
