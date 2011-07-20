//
//  NSURL+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.      2009.
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//

@interface NSURL (PSFoundation)

+ (NSURL *)URLWithStringOrNil:(NSString *)URLString;

- (BOOL)isEqualToURL:(NSURL *)otherURL;

@property (nonatomic, readonly) NSString *baseString;

@end
