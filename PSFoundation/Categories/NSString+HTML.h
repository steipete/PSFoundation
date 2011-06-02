//
//  NSString+FlattenHTML.h
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

- (NSString *)ps_flattenHTML;

- (NSString *)trimWhitespace;
- (NSString *)removeWhitespace; // an alias for trimWhitespace
- (NSString *)removeAllWhitespace;
- (NSString *)replaceAllWhitespaceWithSpace;

- (NSString *)escapeHTML; // aliases for below
- (NSString *)unescapeHTML;

@end

@interface NSString (GTMNSStringHTMLAdditions)

- (NSString *)gtm_stringByEscapingForHTML;
- (NSString *)gtm_stringByUnescapingFromHTML;

@end