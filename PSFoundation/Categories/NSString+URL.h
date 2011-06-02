//
//  NSString+URL.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Sam Soffes.         2010.  MIT.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

@interface NSString (PSStringURL)

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)URLEncodedParameterString;
- (NSString *)URLDecodedParameterString;

- (NSString*) stringByAddingPercentEscapesOnce;
- (NSString*) stringByReplacingPercentEscapesOnce;

- (NSString *)urlWithoutParameters;
- (NSURL *)ps_URL;
- (NSString *)removeQuotes;

@end

@interface NSMutableString (PSStringURL)

// append a parameter to an url
- (NSMutableString *)appendParameter:(id)paramter name:(NSString *)name;

@end
