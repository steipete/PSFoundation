//
//  PSSettingsUtil.h
//  PSFoundation
//
//  Created by Peter Steinberger on 25.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface PSSettingsUtil : NSObject

+ (void)registerDefaultsFromBundle:(NSString *)bundle file:(NSString *)file;
+ (void)registerDefaultsFromSettingsBundle;

@end
