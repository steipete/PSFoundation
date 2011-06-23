#import "NSDictionary+CGStructs.h"

@implementation NSDictionary (CGStructs)

- (CGPoint)pointForKey:(NSString *)key
{
  CGPoint point = CGPointZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)ps_unretainedPointer(dictionary), &point);
  if (success) return point;
  else return CGPointZero;
}

- (CGSize)sizeForKey:(NSString *)key
{
  CGSize size = CGSizeZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)ps_unretainedPointer(dictionary), &size);
  if (success) return size;
  else return CGSizeZero;
}

- (CGRect)rectForKey:(NSString *)key
{
  CGRect rect = CGRectZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)ps_unretainedPointer(dictionary), &rect);
  if (success) return rect;
  else return CGRectZero;
}

@end

@implementation NSMutableDictionary (CGStructs)

- (void)setPoint:(CGPoint)value forKey:(NSString *)key {
    CFDictionaryRef rep = CGPointCreateDictionaryRepresentation(value);
    NSDictionary *dictionary = ps_unretainedObject(rep);
    [self setValue:dictionary forKey:key];
    CFRelease(rep);
}

- (void)setSize:(CGSize)value forKey:(NSString *)key {
    CFDictionaryRef rep = CGSizeCreateDictionaryRepresentation(value);
    NSDictionary *dictionary = ps_unretainedObject(rep);
    [self setValue:dictionary forKey:key];
    CFRelease(rep);
}

- (void)setRect:(CGRect)value forKey:(NSString *)key {
    CFDictionaryRef rep = CGRectCreateDictionaryRepresentation(value);
    NSDictionary *dictionary = ps_unretainedObject(rep);
    [self setValue:dictionary forKey:key];
    CFRelease(rep);
}

@end
