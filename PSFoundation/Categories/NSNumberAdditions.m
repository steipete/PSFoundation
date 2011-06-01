//
//  NSNumberAdditions.m
//
//  Created by Peter Steinberger on 21.09.09.
//

#import "NSNumberAdditions.h"

@implementation NSNumber (PSLib)

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
