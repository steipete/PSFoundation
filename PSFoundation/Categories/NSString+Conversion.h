//
//  NSString+Conversion.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  BSD.
//   - Nicolas Seriot.  2009.
//

@interface NSString (Conversion)

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
+ (NSString *)stringForInteger:(NSInteger)value;
+ (NSString *)stringForUnsignedInteger:(NSUInteger)value;
+ (NSString *)stringForCGFloat:(CGFloat)value;
+ (NSString *)stringForPointer:(void *)value;

- (long)longValue;
- (long long)longLongValue;
- (unsigned long long)unsignedLongLongValue;

@end
