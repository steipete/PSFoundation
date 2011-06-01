//
//  NSString+GSub.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

// https://github.com/yfactorial/objectivesupport
@interface NSString (GSub)

/**
 * Perform basic substitution of given key -> value pairs
 * within this string.
 *
 *   [@"test string substitution" gsub:[NSDictionary withObjectsAndKeys:@"substitution", @"sub"]];
 *     //> @"test string sub"
 */
- (NSString *)gsub:(NSDictionary *)keyValues;
@end
