//
//  NSString+PSFoundation.h
//  PSFoundation
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright 2008 enormego.  Licensed under BSD.
//

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef int NSTruncateStringPosition;

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

/*
 * Truncate string to length
 */
- (NSString *)stringByTruncatingToLength:(int)length;
- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom;
- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis;

- (NSString *)trimWhiteSpace;

// added by PS
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (NSURL *)ps_URL;

@end
