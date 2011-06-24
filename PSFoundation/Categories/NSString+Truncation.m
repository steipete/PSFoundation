//
//  NSString+Truncation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2008.  BSD.
//   - Matthis Tretter.    2011.  MIT.
//   - Peter Steinberger.  2010.  MIT.
//

#import "NSString+Truncation.h"

#define ellipsis @"…"

@implementation NSString (Truncation)

- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font {
    // Create copy that will be the returned result
    NSMutableString *truncatedString = PS_AUTORELEASE([self mutableCopy]);
    
    // Make sure string is longer than requested width
    if ([self sizeWithFont:font].width > width) {
        // Accommodate for ellipsis we'll tack on the end
        width -= [ellipsis sizeWithFont:font].width;
        
        // Get range for last character in string
        NSRange range = {truncatedString.length - 1, 1};
        
        // Loop, deleting characters until string fits within width
        while ([truncatedString sizeWithFont:font].width > width) {
            // Delete character at end
            [truncatedString deleteCharactersInRange:range];
            
            // Move back another character
            range.location--;
        }
        
        // Append ellipsis
        [truncatedString replaceCharactersInRange:range withString:ellipsis];
    }
    
    return truncatedString;
}


- (NSString *)stringByTruncatingToLength:(NSUInteger)length {
	return [self stringByTruncatingToLength:length direction:NSTruncateStringPositionEnd];
}

- (NSString *)stringByTruncatingToLength:(NSUInteger)length direction:(NSTruncateStringPosition)truncateFrom {
	return [self stringByTruncatingToLength:length direction:truncateFrom withEllipsisString:@"..."];
}

- (NSString *)stringByTruncatingToLength:(NSUInteger)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)anEllipsis {
	NSMutableString *result = [self mutableCopy];
	NSString *immutableResult = nil;
    
	if (result.length <= length)
		return self;
    
	NSUInteger charactersEachSide = length / 2;
    
	NSString *first = nil, *last = nil;
    
	switch(truncateFrom) {
		case NSTruncateStringPositionStart:
			[result insertString:anEllipsis atIndex:[result length] - length + [anEllipsis length] ];
			immutableResult  = [[result substringFromIndex:[result length] - length] copy];
			PS_RELEASE_NIL(result);
			return PS_AUTORELEASE(immutableResult);
		case NSTruncateStringPositionMiddle:
			first = [result substringToIndex:charactersEachSide - [anEllipsis length]+1];
			last = [result substringFromIndex:[result length] - charactersEachSide];
			immutableResult = [[[NSArray arrayWithObjects:first, last, NULL] componentsJoinedByString:anEllipsis] copy];
			PS_RELEASE_NIL(result);
			return PS_AUTORELEASE(immutableResult);
		default:
		case NSTruncateStringPositionEnd:
			[result insertString:anEllipsis atIndex:length - [anEllipsis length]];
			immutableResult  = [[result substringToIndex:length] copy];
			PS_RELEASE_NIL(result);
			return PS_AUTORELEASE(immutableResult);
	}
}

- (NSString *)stringWithMaxLength:(NSUInteger)maxLen {
    return [self stringByTruncatingToLength:maxLen];
}

@end
