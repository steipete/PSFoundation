//
//  NSString+PSFoundation.m
//  PSFoundation
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright 2008 enormego.  Licensed under BSD.
//

#import "NSString+PSFoundation.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)

- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

#pragma mark -
#pragma mark Hashes

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString *)md5 {
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString * hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];

	return [hash lowercaseString];
}

#pragma mark -
#pragma mark Truncation

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString *)stringByTruncatingToLength:(int)length {
	return [self stringByTruncatingToLength:length direction:NSTruncateStringPositionEnd];
}

- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom {
	return [self stringByTruncatingToLength:length direction:truncateFrom withEllipsisString:@"..."];
}

- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis {
	NSMutableString *result = [[NSMutableString alloc] initWithString:self];
	NSString *immutableResult;

	if([result length] <= length) {
		[result release];
		return self;
	}

	unsigned int charactersEachSide = length / 2;

	NSString * first;
	NSString * last;

	switch(truncateFrom) {
		case NSTruncateStringPositionStart:
			[result insertString:ellipsis atIndex:[result length] - length + [ellipsis length] ];
			immutableResult  = [[result substringFromIndex:[result length] - length] copy];
			[result release];
			return [immutableResult autorelease];
		case NSTruncateStringPositionMiddle:
			first = [result substringToIndex:charactersEachSide - [ellipsis length]+1];
			last = [result substringFromIndex:[result length] - charactersEachSide];
			immutableResult = [[[NSArray arrayWithObjects:first, last, NULL] componentsJoinedByString:ellipsis] copy];
			[result release];
			return [immutableResult autorelease];
		default:
		case NSTruncateStringPositionEnd:
			[result insertString:ellipsis atIndex:length - [ellipsis length]];
			immutableResult  = [[result substringToIndex:length] copy];
			[result release];
			return [immutableResult autorelease];
	}
}

- (NSString *)trimWhiteSpace {
	NSMutableString *s = [[self mutableCopy] autorelease];
	CFStringTrimWhitespace ((CFMutableStringRef) s);
	return (NSString *) [[s copy] autorelease];
} /*trimWhiteSpace*/


// replaces string with new string, returns new var
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString {
    NSMutableString *mutable = [NSMutableString stringWithString:self];
    [mutable replaceOccurrencesOfString:searchString withString:newString options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
    return [NSString stringWithString:mutable];
}

- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]<>"),
                                                                           kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}

- (NSString*)URLDecodedString {
    NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}

- (NSURL *)ps_URL; {
    NSURL *url = nil;
    if ([self hasPrefix:@"http"]) {
        url = [NSURL URLWithString:self];
    }else if([self length] > 0) {
        url = [NSURL fileURLWithPath:self];
    }

    return url;
}

@end
