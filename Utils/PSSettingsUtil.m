//
//  PSSettingsUtil.m
//  PSFoundation
//
//  Created by Peter Steinberger on 25.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSSettingsUtil.h"


@implementation PSSettingsUtil

// http://stackoverflow.com/questions/510216/can-you-make-the-settings-in-settings-bundle-default-even-if-you-dont-open-the-s
+ (void)registerDefaultsFromBundle:(NSString *)settingsBundle file:(NSString *)file {

  NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:file]];
  NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];

  NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
  for(NSDictionary *prefSpecification in preferences) {
    NSString *key = [prefSpecification objectForKey:@"Key"];
    id defaultValue = [prefSpecification objectForKey:@"DefaultValue"];
    if(key && defaultValue) {
      [defaultsToRegister setObject:defaultValue forKey:key];
    }
  }

  // http://stackoverflow.com/questions/2076816/how-to-register-user-defaults-using-nsuserdefaults-without-overwriting-existing-v
  [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
  [defaultsToRegister release];
}

+ (void)registerDefaultsFromSettingsBundle {
  NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
  if(!settingsBundle) {
    DDLogWarn(@"Could not find Settings.bundle");
    return;
  }

  [self registerDefaultsFromBundle:settingsBundle file:@"Root.plist"];
}

@end
