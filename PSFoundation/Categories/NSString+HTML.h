//
//  NSString+HTML.h
//  PSFoundation
//
//  Includes code by the following:
//   - Google.             2009.  Apache.
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//
//  References:
//   - http://stackoverflow.com/questions/277055/remove-html-tags-from-an-nsstring-on-the-iphone
//

@interface NSString(PSStringHTML)

- (NSString *)trimWhitespace;
- (NSString *)trimWhitespaceWithSpace;

- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;

@end