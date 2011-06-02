//
//  NSString+Conversion.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  BSD.
//   - Nicolas Seriot.  2009.
//

#import "NSString+Conversion.h"

@implementation NSString (Conversion)

+ (NSString *)stringForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble {
    return [NSString stringWithFormat:@"%d %@ %s %f %f", aBool, aString, aCharPtr, aFloat, aDouble];
}

+ (NSString *)stringForBool:(BOOL)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)stringForInt:(int)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)stringForFloat:(float)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)stringForDouble:(double)value {
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)stringForSelector:(SEL)value {
    return NSStringFromSelector(value);
}

+ (NSString *)stringForChar:(char)value {
    return [NSString stringWithFormat:@"%c", value];
}

+ (NSString *)stringForShort:(short)value {
    return [NSString stringWithFormat:@"%s", value];
}

+ (NSString *)stringForCppBool:(bool)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)stringForUChar:(unsigned char)value {
    return [NSString stringWithFormat:@"%c", value];
}

+ (NSString *)stringForUShort:(unsigned short)value {
    return [NSString stringWithFormat:@"%hu", value]; 
}

+ (NSString *)stringForLong:(long)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)stringForLongLong:(long long)value {
    return [NSString stringWithFormat:@"%qi", value];
}

+ (NSString *)stringForUInt:(unsigned int)value {
    return [NSString stringWithFormat:@"%u", value];
}

+ (NSString *)stringForULong:(unsigned long)value {
    return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)stringForULongLong:(unsigned long long)value {
    return [NSString stringWithFormat:@"%qu", value];
}

+ (NSString *)stringForCharPtr:(long long)value {
    return [NSString stringWithFormat:@"%s", value];
}

+ (NSString *)stringForObject:(id)value {
    return [value description];
}

+ (NSString *)stringForClass:(Class)value {
    return NSStringFromClass(value);
}

+ (NSString *)stringForInteger:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)stringForUnsignedInteger:(NSUInteger)value {
    return [NSString stringWithFormat:@"%lu", value];
}

+ (NSString *)stringForCGFloat:(CGFloat)value {
    return [NSString stringWithFormat:@"%.02f", value];
}

+ (NSString *)stringForPointer:(void *)value {
    return [NSString stringWithFormat:@"%p", value];
}

- (long)longValue {
	return (long)[self longLongValue];
}

- (long long)longLongValue {
	NSScanner* scanner = [NSScanner scannerWithString:self];
	long long valueToGet;
	if([scanner scanLongLong:&valueToGet] == YES) {
		return valueToGet;
	} else {
		return 0;
	}
}

- (unsigned long long)unsignedLongLongValue {
	NSUInteger n = [self length];
	unsigned long long v,a;
	unsigned small_a, j;
    
	v=0;
	for (j=0;j<n;j++) {
		unichar c=[self characterAtIndex:j];
        if ((c>47)&&(c<58))
            small_a = c-48;
        else
            small_a = 10;
		if (small_a==10) continue;
		a=(unsigned long long)small_a;
		v=(10*v)+a;
	}
    
	return v;
    
}

- (NSString *)arrayWithStringRepresentationsForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble {
	return [NSString stringForBool:aBool string:aString charPtr:aCharPtr aFloat:aFloat aDouble:aDouble];
}

- (NSString *)stringRepresentationForBool:(BOOL)value {
	return [NSString stringForBool:value];
}

- (NSString *)stringRepresentationForInt:(int)value {
	return [NSString stringForInt:value];
}

- (NSString *)stringRepresentationForFloat:(float)value {
	return [NSString stringForFloat:value];
}

- (NSString *)stringRepresentationForDouble:(double)value {
	return [NSString stringForDouble:value];
}

- (NSString *)stringRepresentationForSelector:(SEL)value {
	return [NSString stringForSelector:value];
}

- (NSString *)stringRepresentationForChar:(char)value {
	return [NSString stringForChar:value];
}

- (NSString *)stringRepresentationForShort:(short)value {
    return [NSString stringForShort:value];
}

- (NSString *)stringRepresentationForCppBool:(bool)value {
	return [NSString stringForCppBool:value];
}

- (NSString *)stringRepresentationForUChar:(unsigned char)value {
	return [NSString stringForUChar:value];
}

- (NSString *)stringRepresentationForUShort:(unsigned short)value {
	return [NSString stringForUShort:value];
}

- (NSString *)stringRepresentationForLong:(long)value {
	return [NSString stringForLong:value];
}

- (NSString *)stringRepresentationForLongLong:(long long)value {
	return [NSString stringForLongLong:value];
}

- (NSString *)stringRepresentationForUInt:(unsigned int)value {
	return [NSString stringForUInt:value];
}

- (NSString *)stringRepresentationForULong:(unsigned long)value {
	return [NSString stringForULong:value];
}

- (NSString *)stringRepresentationForULongLong:(unsigned long long)value {
	return [NSString stringForULongLong:value];
}

- (NSString *)stringRepresentationForCharPtr:(long long)value {
	return [NSString stringForCharPtr:value];
}

- (NSString *)stringRepresentationForObject:(id)value {
	return [NSString stringForObject:value];
}

- (NSString *)stringRepresentationForClass:(Class)value {
	return [NSString stringForClass:value];
}

- (NSString *)stringRepresentationForNSInteger:(NSInteger)value {
	return [NSString stringForInteger:value];
}

- (NSString *)stringRepresentationForNSUInteger:(NSUInteger)value {
	return [NSString stringForUnsignedInteger:value];
}

- (NSString *)stringRepresentationForCGFloat:(CGFloat)value {
	return [NSString stringForCGFloat:value];
}

- (NSString *)stringRepresentationForPointer:(void *)value {
	return [NSString stringForPointer:value];
}

@end