//
//  NSString+FlattenHTML.m
//
//  Created by Peter Steinberger on 18.01.10.
//

#import "NSString+FlattenHTML.h"

@implementation NSString (FlattenHTML)

- (NSString *)removeWhitespace {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// even in the middle, like strange whitespace due &nbsp;
- (NSString *)removeAllWhitespaces {
  return [[self componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
}

- (NSString *)replaceAllWhitespacesWithSpace {
  return [[self componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @" "];
}

@end
