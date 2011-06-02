//
//  NSString+Cat.m
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

#import "NSString+Cat.h"


@implementation NSString (Cat)

- (BOOL)isOk {
	return YES;
}

- (BOOL)isLongerThan:(NSUInteger)length {
	return [self length] > length;
}

- (NSString *)arrayWithStringRepresentationsForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble {
	return [NSString stringWithFormat:@"%d %@ %s %f %f", aBool, aString, aCharPtr, aFloat, aDouble];
}

- (NSString *)stringRepresentationForBool:(BOOL)aBool {
	return [NSString stringWithFormat:@"%d", aBool];
}

- (NSString *)stringRepresentationForInt:(int)anInt {
	return [NSString stringWithFormat:@"%d", anInt];
}

- (NSString *)stringRepresentationForFloat:(float)aFloat {
	return [NSString stringWithFormat:@"%f", aFloat];
}

- (NSString *)stringRepresentationForDouble:(double)aDouble {
	return [NSString stringWithFormat:@"%f", aDouble];
}

- (NSString *)stringRepresentationForSelector:(SEL)aSelector {
	return NSStringFromSelector(aSelector);
}

- (NSString *)stringRepresentationForChar:(char)aChar {
	return [NSString stringWithFormat:@"%c", aChar];
}

- (NSString *)stringRepresentationForShort:(short)aShort {
	return [NSString stringWithFormat:@"%hi", aShort];
}

- (NSString *)stringRepresentationForCppBool:(bool)aCppBool {
	return [NSString stringWithFormat:@"%d", aCppBool];
}

- (NSString *)stringRepresentationForUChar:(unsigned char)aUChar {
	return [NSString stringWithFormat:@"%c", aUChar];
}

- (NSString *)stringRepresentationForUShort:(unsigned short)aUShort {
	return [NSString stringWithFormat:@"%hu", aUShort];
}

- (NSString *)stringRepresentationForLong:(long)aLong {
	return [NSString stringWithFormat:@"%ld", aLong];
}

- (NSString *)stringRepresentationForLongLong:(long long)aLongLong {
	return [NSString stringWithFormat:@"%qi", aLongLong];
}

- (NSString *)stringRepresentationForUInt:(unsigned int)aUInt {
	return [NSString stringWithFormat:@"%u", aUInt];
}

- (NSString *)stringRepresentationForULong:(unsigned long)aULong {
	return [NSString stringWithFormat:@"%d", aULong];
}

- (NSString *)stringRepresentationForULongLong:(unsigned long long)aULongLong {
	return [NSString stringWithFormat:@"%qu", aULongLong];
}

- (NSString *)stringRepresentationForCharPtr:(long long)aCharPtr {
	return [NSString stringWithFormat:@"%s", aCharPtr];
}

- (NSString *)stringRepresentationForObject:(id)anObject {
	return [anObject description];
}

- (NSString *)stringRepresentationForClass:(Class)aClass {
	return NSStringFromClass(aClass);
}

- (NSString *)stringRepresentationForNSInteger:(NSInteger)aNSInteger {
	return [NSString stringWithFormat:@"%ld", aNSInteger];
}

- (NSString *)stringRepresentationForNSUInteger:(NSUInteger)aNSUInteger {
	return [NSString stringWithFormat:@"%lu", aNSUInteger];
}

- (NSString *)stringRepresentationForCGFloat:(CGFloat)aCGFloat {
	return [NSString stringWithFormat:@"%.02f", aCGFloat];
}

- (NSString *)stringRepresentationForPointer:(void *)aPointer {
	return [NSString stringWithFormat:@"%p", aPointer];
}

@end
