//
//  NSDictionary+CGStructs.m
//  PSFoundation
//

#import "NSDictionary+CGStructs.h"

@implementation NSDictionary (CGStructs)

- (CGPoint)pointForKey:(NSString *)key
{
    CGPoint point = CGPointZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &point);
    if (!success)
      return CGPointZero;
    return point;
}

- (CGSize)sizeForKey:(NSString *)key
{
    CGSize size = CGSizeZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &size);
    if (!success)
        return CGSizeZero;
    return size;
}

- (CGRect)rectForKey:(NSString *)key
{
    CGRect rect = CGRectZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &rect);
    if (!success)
        return CGRectZero;
    return rect;
}

@end

@implementation NSMutableDictionary (CGStructs)

- (void)setPoint:(CGPoint)value forKey:(NSString *)key {
    CFDictionaryRef dict = CGPointCreateDictionaryRepresentation(value);
    [self setValue:(id)dict forKey:key];
    CFRelease(dict);
}

- (void)setSize:(CGSize)value forKey:(NSString *)key {
    CFDictionaryRef dict = CGSizeCreateDictionaryRepresentation(value);
    [self setValue:(id)dict forKey:key];
    CFRelease(dict);
}

- (void)setRect:(CGRect)value forKey:(NSString *)key {
    CFDictionaryRef dict = CGRectCreateDictionaryRepresentation(value);
    [self setValue:(id)dict forKey:key];
    CFRelease(dict);
}

@end
