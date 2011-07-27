//
//  NSString+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Sam Soffes.         2010.  MIT.
//   - Peter Steinberger.  2010.  MIT.
//   - Matthias Tretter.   2011.  MIT.
//

#import "NSString+PSFoundation.h"
#import "NSData+PSCommonCrypto.h"
#import "NSData+PSBase64.h"

int const GGCharacterIsNotADigit = 10;

@implementation NSString (PSFoundation)

- (BOOL)isEmpty {
    return (!self.length || ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length);
}

+ (NSString *)stringWithUUID {
	CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *value = (NSString *)CFUUIDCreateString(nil, uuid);
    CFRelease(uuid);
    return [value autorelease];
}

+ (NSString *)stringWithData:(NSData *)data {
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

- (NSString *)stringAfterSubstring:(NSString*)substring {
    return ([self containsString:substring]) ? [self substringFromIndex:NSMaxRange([self rangeOfString:substring])] : nil; 
}

- (NSComparisonResult)compareToVersionString:(NSString *)version {
	// Break version into fields (separated by '.')
    NSMutableArray *rightFields = [NSMutableArray arrayWithArray:[self componentsSeparatedByString:@"."]];
    NSMutableArray *leftFields = [NSMutableArray arrayWithArray:[version componentsSeparatedByString:@"."]];
	
	// Implict ".0" in case version doesn't have the same number of '.'
	if ([leftFields count] < [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[leftFields addObject:@"0"];
		}
	} else if ([leftFields count] > [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[rightFields addObject:@"0"];
		}
	}
	
	// Do a numeric comparison on each field
	for (NSUInteger i = 0; i < leftFields.count; i++) {
		NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
		if (result != NSOrderedSame)
			return result;
	}
	
	return NSOrderedSame;
}

- (BOOL)isEqualToStringIgnoringCase:(NSString*)otherString {
	if (otherString.empty)
		return NO;
	return ([self compare:otherString options:NSCaseInsensitiveSearch | NSWidthInsensitiveSearch] == NSOrderedSame);
}

- (NSString *)md5 {
    NSData *sum = [[self dataUsingEncoding:NSUTF8StringEncoding] MD5Sum];
    return [[[NSString alloc] initWithData:sum encoding:NSUTF8StringEncoding] autorelease];
}

- (NSString *)sha1 {
    NSData *sum = [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1Hash];
    return [[[NSString alloc] initWithData:sum encoding:NSUTF8StringEncoding] autorelease];
}

- (NSString *)base64 {
    return [NSData stringByEncodingData:[self dataUsingEncoding:NSUTF8StringEncoding]];
}

@end