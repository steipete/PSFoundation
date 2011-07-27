//
//  NSDictionary+PSFoundation.m
//  PSFoundation
//

#import "NSDictionary+PSFoundation.h"

@implementation NSDictionary (PSFoundation)

- (BOOL)containsObjectForKey:(id)key {
	return [[self allKeys] containsObject:key];
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (CGPoint)pointForKey:(NSString *)key {
    CGPoint point = CGPointZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &point);
    if (!success)
        return CGPointZero;
    return point;
}

- (CGSize)sizeForKey:(NSString *)key {
    CGSize size = CGSizeZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &size);
    if (!success)
        return CGSizeZero;
    return size;
}

- (CGRect)rectForKey:(NSString *)key {
    CGRect rect = CGRectZero;
    NSDictionary *dictionary = [self valueForKey:key];
    BOOL success = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &rect);
    if (!success)
        return CGRectZero;
    return rect;
}

@end

@implementation NSMutableDictionary (PSFoundation)

- (void) setObjectToObjectForKey:(id)key inDictionary:(NSDictionary*)otherDictionary {
    id obj = [otherDictionary objectForKey:key];
    if (obj)
		[self setObject:obj forKey:key];
}

- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey {
    if (aKey)
        [self setObject:anObject forKey:aKey];
}

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