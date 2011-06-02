//
//  NSString+Replacement.h
//  PSFoundation
//
//  Includes code by the following:
//   - Ryan Daigle.        2008.  
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

@interface NSString (PSStringReplacement)

- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString;
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString;

/**
 * Perform basic substitution of given key -> value pairs
 * within this string.
 *
 *   [@"test string substitution" gsub:[NSDictionary withObjectsAndKeys:@"substitution", @"sub"]];
 *     //> @"test string sub"
 */
- (NSString *)gsub:(NSDictionary *)keyValues;


- (BOOL)isLongerThan:(NSUInteger)length;

@end

@interface NSMutableString (PSStringReplacement)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

@end
