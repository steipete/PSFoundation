//
//  NilCategories.m
//
//  Based on Vincent Gable
//

#import "NilCategories.h"
#import "VTPG_Common.h"

@implementation NSString (NilCategories)
//builds a URL from the string
//
- (NSURL*)convertToURL;
{
  if (self) {
    return [NSURL URLWithString:self];
  }else {
    return nil;
  }
}

//+[NSURL URLWithString:relativeToURL:] throws an exception
- (NSURL*) convertToURLRelitiveToURL:(NSURL*)baseURL;
{
	if(!baseURL)
		return nil;
	return [NSURL URLWithString:self relativeToURL:baseURL];
}

@end

@implementation NSArray (NilCategories)
- (id) objectOrNilAtIndex:(NSUInteger)i;
{
	if(i >= [self count] || i < 0)
		return nil;
	return [self objectAtIndex:i];
}
@end

@implementation NSMutableArray (NilCategories)

- (void)addObjectIfNotNil:(id)anObject {
  if (anObject) {
    [self addObject:anObject];
  }
}

- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray {
 if (!IsEmpty(otherArray) && [otherArray isKindOfClass:[NSArray class]]) {
   [self addObjectsFromArray:otherArray];
   return YES;
 }
  return NO;
}

@end



@implementation NSMutableDictionary (NilCategories)

- (void) setObjectToObjectForKey:(id)key inDictionary:(NSDictionary*)otherDictionary {
	id obj = [otherDictionary objectForKey:key];
	if(obj)
		[self setObject:obj forKey:key];
}

- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey {
  if (aKey) {
    [self setObject:anObject forKey:aKey];
  }
}

@end

@implementation NSMutableSet (NilCategories)

- (void)addObjectIfNotNil:(id)anObject {
  if (anObject) {
    [self addObject:anObject];
  }
}

@end
