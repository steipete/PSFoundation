//
//  NSURL+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//

@interface NSURL (PSFoundation)

- (BOOL) isEqualToURL:(NSURL*)otherURL;

@property (readonly) NSString *baseString;

@end
