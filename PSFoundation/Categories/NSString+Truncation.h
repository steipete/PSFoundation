//
//  NSString+Truncation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2008.  BSD.
//   - Matthis Tretter.    2011.  MIT.
//   - Peter Steinberger.  2010.  MIT.
//

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef int NSTruncateStringPosition;

@interface NSString (Truncation)

- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;
- (NSString *)stringByTruncatingToLength:(NSUInteger)length;
- (NSString *)stringByTruncatingToLength:(NSUInteger)length direction:(NSTruncateStringPosition)truncateFrom;
- (NSString *)stringByTruncatingToLength:(NSUInteger)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis;

@end