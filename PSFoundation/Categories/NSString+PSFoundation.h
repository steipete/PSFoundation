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

@interface NSString (PSFoundation)

+ (NSString*) stringWithUUID;

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;
- (BOOL)hasSubstring:(NSString*)substring;
- (NSString*)substringAfterSubstring:(NSString*)substring;

- (NSComparisonResult)compareToVersionString:(NSString *)version;
- (BOOL)isEqualToStringIgnoringCase:(NSString*)otherString;

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)base64;

@end