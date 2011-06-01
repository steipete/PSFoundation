#import "NSDictionary+CGStructs.h"

@implementation NSDictionary (CGStructs)

- (CGPoint)pointForKey:(NSString *)key
{
  CGPoint point = CGPointZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &point);
  if (success) return point;
  else return CGPointZero;
}

- (CGSize)sizeForKey:(NSString *)key
{
  CGSize size = CGSizeZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &size);
  if (success) return size;
  else return CGSizeZero;
}

- (CGRect)rectForKey:(NSString *)key
{
  CGRect rect = CGRectZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &rect);
  if (success) return rect;
  else return CGRectZero;
}

@end

@implementation NSMutableDictionary (CGStructs)

- (void)setPoint:(CGPoint)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (NSDictionary *)CGPointCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

- (void)setSize:(CGSize)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (NSDictionary *)CGSizeCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

- (void)setRect:(CGRect)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (NSDictionary *)CGRectCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

@end
