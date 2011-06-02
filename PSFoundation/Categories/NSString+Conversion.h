//
//  NSString+Conversion.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  BSD.
//   - Nicolas Seriot.  2009.
//

@interface NSString (Conversion)

+ (NSString *)stringForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble;
+ (NSString *)stringForBool:(BOOL)value;
+ (NSString *)stringForInt:(int)value;
+ (NSString *)stringForFloat:(float)value;
+ (NSString *)stringForDouble:(double)value;
+ (NSString *)stringForSelector:(SEL)value;
+ (NSString *)stringForChar:(char)value;
+ (NSString *)stringForShort:(short)value;
+ (NSString *)stringForCppBool:(bool)value;
+ (NSString *)stringForUChar:(unsigned char)value;
+ (NSString *)stringForUShort:(unsigned short)value;
+ (NSString *)stringForLong:(long)value;
+ (NSString *)stringForLongLong:(long long)value;
+ (NSString *)stringForUInt:(unsigned int)value;
+ (NSString *)stringForULong:(unsigned long)value;
+ (NSString *)stringForULongLong:(unsigned long long)value;
+ (NSString *)stringForCharPtr:(long long)value;
+ (NSString *)stringForObject:(id)value;
+ (NSString *)stringForClass:(Class)value;
+ (NSString *)stringForInteger:(NSInteger)value;
+ (NSString *)stringForUnsignedInteger:(NSUInteger)value;
+ (NSString *)stringForCGFloat:(CGFloat)value;
+ (NSString *)stringForPointer:(void *)value;

/*
 * Returns the long value of the string
 */
- (long)longValue;
- (long long)longLongValue;
- (unsigned long long)unsignedLongLongValue;

// Ugly ugly ugly
- (NSString *)arrayWithStringRepresentationsForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForBool:(BOOL)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForInt:(int)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForFloat:(float)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForDouble:(double)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForSelector:(SEL)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForChar:(char)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForShort:(short)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForCppBool:(bool)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForUChar:(unsigned char)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForUShort:(unsigned short)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForLong:(long)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForLongLong:(long long)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForUInt:(unsigned int)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForULong:(unsigned long)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForULongLong:(unsigned long long)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForCharPtr:(long long)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForObject:(id)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForClass:(Class)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForNSInteger:(NSInteger)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForNSUInteger:(NSUInteger)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForCGFloat:(CGFloat)value DEPRECATED_ATTRIBUTE;
- (NSString *)stringRepresentationForPointer:(void *)value DEPRECATED_ATTRIBUTE;

@end
