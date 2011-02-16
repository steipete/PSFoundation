//
//  NSMutableString+PSAdditions.m
//  PSFoundation
//
//  Created by Peter Steinberger on 15.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "NSMutableString+PSAdditions.h"


@implementation NSMutableString (PSAdditions)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
  return [self replaceOccurrencesOfString:target withString:replacement options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
}


- (NSMutableString *)appendParameter:(id)paramter name:(NSString *)name {
  if (!paramter) {
    DDLogWarn(@"Parameter is empty, not adding.");
    return self;
  }
  BOOL needsQMark = [self rangeOfString:@"?" options:0].location == NSNotFound;
  if (needsQMark) {
    [self appendString:@"?"];
  }

  BOOL charOnEnd = [self hasSuffix:@"&"] || [self hasSuffix:@"?"];
  if (!charOnEnd) {
    [self appendString:@"&"];
  }

  if ([paramter isKindOfClass:[NSArray class]]) {
    [(NSArray *)paramter enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [self appendFormat:@"%@%@[]=%@", (idx > 0 ? @"&" : @""), name, obj];
    }];
  }else {
    [self appendFormat:@"%@=%@", name, paramter];
  }
  return self;
}


@end
