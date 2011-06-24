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
#import "NSData+CommonCrypto.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (PSFoundation)

+ (NSString *)stringWithUUID {
	CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef string = CFUUIDCreateString(nil, uuid);
    NSString *value = [[NSString alloc] initWithString:ps_unretainedObject(string)];
    CFRelease(string);
    CFRelease(uuid);
    return PS_AUTORELEASE(value);
}

- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

- (BOOL)hasSubstring:(NSString *)substring {
    return [self containsString:substring];
}

- (NSString*) substringAfterSubstring:(NSString*)substring {
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
    return PS_AUTORELEASE([[NSString alloc] initWithData:sum encoding:NSUTF8StringEncoding]);
}

- (NSString *)sha1 {
    NSData *sum = [[self dataUsingEncoding:NSUTF8StringEncoding] SHA1Hash];
    return PS_AUTORELEASE([[NSString alloc] initWithData:sum encoding:NSUTF8StringEncoding]);
}

- (NSString *)base64 {
    return [GTMBase64 stringByEncodingData:[self dataUsingEncoding:NSUTF8StringEncoding]];
}

@end