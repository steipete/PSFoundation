//
//  NSDictionary+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

#import "NSDictionary+PSFoundation.h"

@implementation NSDictionary (PSFoundation)

- (BOOL)containsObjectForKey:(id)key {
	return [[self allKeys] containsObject:key];
}

- (BOOL)isEmpty {
    return (self.count == 0);
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

@end