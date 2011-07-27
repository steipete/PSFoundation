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

- (NSString *)stringByReplacingRange:(NSRange)aRange withString:(NSString *)aString;
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString;
- (NSString *)stringByReplacingKeysWithValues:(NSDictionary *)dictionary;
/**
 * Perform basic substitution of given key -> value pairs
 * within this string.
 *
 *   [@"test string substitution" gsub:[NSDictionary withObjectsAndKeys:@"substitution", @"sub"]];
 *     //> @"test string sub"
 */
- (NSString *)stringByReplacingKeysWithValues:(NSDictionary *)dictionary;

@end

@interface NSMutableString (PSStringReplacement)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;
- (void)replaceKeysWithValues:(NSDictionary *)keyValues;

@end
