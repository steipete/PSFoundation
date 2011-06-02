//
//  NSString+PSFoundation.h
//  PSFoundation
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright 2008 enormego.  Licensed under BSD.
//

@interface NSString (Helper)

/*
 * Checks to see if the string contains the given string, case insenstive
 */
- (BOOL)containsString:(NSString *)string;

/*
 * Checks to see if the string contains the given string while allowing you to define the compare options
 */
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;

/*
 * Returns the MD5 value of the string
 */
- (NSString *)md5;

- (NSString *)trimWhiteSpace;

// added by PS
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSURL *)ps_URL;

@end
