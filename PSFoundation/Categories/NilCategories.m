//
//  NilCategories.m
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

#import "NilCategories.h"
//#import "VTPG_Common.h"

@implementation NSObject (NilCategories)

// basic blanket implementation
- (BOOL)isEmpty {
    return self == nil ||
    ([self isEqual:[NSNull null]]) ||
    ([self respondsToSelector:@selector(length)] && [(NSData *)self length] == 0) ||
    ([self respondsToSelector:@selector(count)]  && [(NSArray *)self count] == 0);
}

@end

@implementation NSString (NilCategories)

//builds a URL from the string
- (NSURL*)convertToURL {
    if (self)
        return [NSURL URLWithString:self];
    else
        return nil;
}

//+[NSURL URLWithString:relativeToURL:] throws an exception
- (NSURL*)convertToURLRelativeToURL:(NSURL*)baseURL {
	if(!baseURL)
		return nil;
	return [NSURL URLWithString:self relativeToURL:baseURL];
}

- (BOOL)isEmpty {
    return !self.length || ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

- (BOOL)isNotEmpty {
    return !self.empty;
}

- (BOOL)isEmptyOrWhitespace {
    return self.empty;
}

- (BOOL)isWhitespaceAndNewlines {
    return self.empty;
}

@end

@implementation NSArray (NilCategories)

- (id)objectOrNilAtIndex:(NSUInteger)i {
    if (i >= self.count)
		return nil;
	return [self objectAtIndex:i];
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

@end

@implementation NSMutableArray (NilCategories)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject)
      [self addObject:anObject];
}

- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray {
    if (![otherArray isEmpty] && [otherArray isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:otherArray];
        return YES;
    }
    return NO;
}

@end

@implementation NSDictionary (NilCategories)

- (BOOL)containsObjectForKey:(id)key {
	return [[self allKeys] containsObject:key];
}

- (BOOL)isEmpty {
    return (self.count == 0);
}

@end

@implementation NSMutableDictionary (NilCategories)

- (void) setObjectToObjectForKey:(id)key inDictionary:(NSDictionary*)otherDictionary {
    id obj = [otherDictionary objectForKey:key];
    if (obj)
		[self setObject:obj forKey:key];
}

- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey {
    if (aKey)
        [self setObject:anObject forKey:aKey];
}

@end

@implementation NSSet (NilCategories)

- (BOOL)isEmpty {
    return (self.count == 0);
}

@end

@implementation NSMutableSet (NilCategories)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject)
        [self addObject:anObject];
}

@end

@implementation NSURL (NilCategories)

+ (NSURL *)URLWithStringOrNil:(NSString *)URLString {
    if (URLString)
        return [NSURL URLWithString:URLString];
    return nil;
}

@end