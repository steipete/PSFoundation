//
//  NSNumber+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 04.11.09.
//  Licensed under MIT.  All rights reserved.
//

#import "NSNumber+PSFoundation.h"

@implementation NSNumber (PSFoundation)

static NSNumberFormatter *numberFormatter = nil;

+ (NSNumber *)numberWithString:(NSString *)string {
  if(numberFormatter == nil) {
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];    
  }
  
  // more sanity checks
  if (string) {
    @try {
      return [numberFormatter numberFromString:string];
    }
    @catch (NSException * e) {
      DDLogError(@"NSNumberFormatter exception! parsing: %@", string);
    }
  }
  return nil;
}

@end
