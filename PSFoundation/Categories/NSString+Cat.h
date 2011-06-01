//
//  NSString+Cat.h
//  Functional
//
//  Created by Nicolas Seriot on 08.01.09.
//  Copyright 2009 Sen:te. All rights reserved.
//

@interface NSString (Cat)

- (BOOL)isOk;

- (BOOL)isLongerThan:(NSUInteger)length;
- (NSString *)arrayWithStringRepresentationsForBool:(BOOL)aBool string:(NSString *)aString charPtr:(char *)aCharPtr aFloat:(float)aFloat aDouble:(double)aDouble ;

- (NSString *)stringRepresentationForBool:(BOOL)aBool;
- (NSString *)stringRepresentationForInt:(int)anInt;
- (NSString *)stringRepresentationForFloat:(float)aFloat;
- (NSString *)stringRepresentationForDouble:(double)aDouble;
- (NSString *)stringRepresentationForSelector:(SEL)aSelector;
- (NSString *)stringRepresentationForChar:(char)aChar;
- (NSString *)stringRepresentationForShort:(short)aShort;
- (NSString *)stringRepresentationForCppBool:(bool)aCppBool;
- (NSString *)stringRepresentationForUChar:(unsigned char)aUChar;
- (NSString *)stringRepresentationForUShort:(unsigned short)aUShort;
- (NSString *)stringRepresentationForLong:(long)aLong;
- (NSString *)stringRepresentationForLongLong:(long long)aLongLong;
- (NSString *)stringRepresentationForUInt:(unsigned int)aUInt;
- (NSString *)stringRepresentationForULong:(unsigned long)aULong;
- (NSString *)stringRepresentationForULongLong:(unsigned long long)aULongLong;
- (NSString *)stringRepresentationForCharPtr:(long long)aCharPtr;
- (NSString *)stringRepresentationForObject:(id)anObject;
- (NSString *)stringRepresentationForClass:(Class)aClass;
- (NSString *)stringRepresentationForNSInteger:(NSInteger)aNSInteger;
- (NSString *)stringRepresentationForNSUInteger:(NSUInteger)aNSUInteger;
- (NSString *)stringRepresentationForCGFloat:(CGFloat)aCGFloat;
- (NSString *)stringRepresentationForPointer:(void *)aPointer;

@end
