//
//  StringUtil.h
//  Peter Steinberger
//

@interface NSString (NSStringUtils)

- (NSString *)urlWithoutParameters;
- (NSString *)stringByReplacingRange:(NSRange)aRange with:(NSString *)aString;

@end

@interface NSString (IndempotentPercentEscapes)
//uses UTF8 encoding, behavior is undefined if for other encodings.
- (NSString*) stringByAddingPercentEscapesOnce;
- (NSString*) stringByReplacingPercentEscapesOnce;
@end

@interface NSString (UUID)
//returns a new string built from a new UUID.
+ (NSString*) stringWithUUID;
@end

@interface NSString  (RangeAvoidance)
- (BOOL) hasSubstring:(NSString*)substring;
- (NSString*) substringAfterSubstring:(NSString*)substring;

//Note: -isCaseInsensitiveLike is probably a better alternitive if it's avalible.
- (BOOL) isEqualToStringIgnoringCase:(NSString*)otherString;
@end


