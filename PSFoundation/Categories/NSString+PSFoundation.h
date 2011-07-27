//
//  NSString+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Sam Soffes.         2010.  MIT.
//   - Peter Steinberger.  2010.  MIT.
//   - Matthias Tretter.   2011.  MIT.
//

#import "NSObject+Utilities.h"

@interface NSString (PSFoundation)

+ (NSString *)stringWithUUID;
+ (NSString *)stringWithData:(NSData *)data;

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;
- (NSString *)stringAfterSubstring:(NSString *)substring;

- (NSComparisonResult)compareToVersionString:(NSString *)version;
- (BOOL)isEqualToStringIgnoringCase:(NSString*)otherString;

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)base64;

@end