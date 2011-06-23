//
//  NSArray+Filtering.m
//  PSFoundation
//
//  Includes code by the following:
//   - Erica Sadun.       2009.  Public domain.
//   - Peter Steinberger. 2009.  MIT.
//   - Matthias Tretter.  2010.  MIT.
//

#import "NSArray+Filtering.h"
#import "NSArray+Structures.h"
#import <time.h>
#import <stdarg.h>

#pragma mark UtilityExtensions
@implementation NSArray (PSArrayAlgebra)

- (id)uniqueMembers {
	NSMutableArray __ps_autoreleasing *copy = [self mutableCopy];
	for (id object in self) {
		[copy removeObjectIdenticalTo:object];
		[copy addObject:object];
	}
	return PS_AUTORELEASE(copy);
}

- (id) unionWithArray:(NSArray *)anArray {
	if (!anArray) return self;
	return [[self arrayByAddingObjectsFromArray:anArray] uniqueMembers];
}

- (id)intersectionWithArray:(NSArray *)anArray {
	NSMutableArray __ps_autoreleasing *copy = [self mutableCopy];
	for (id object in self)
		if (![anArray containsObject:object])
			[copy removeObjectIdenticalTo:object];
	return PS_AUTORELEASE([copy uniqueMembers]);
}

- (id)intersectionWithSet:(NSSet *)anSet {
	NSMutableArray __ps_autoreleasing *copy = [self mutableCopy];
	for (id object in self)
		if (![anSet containsObject:object])
			[copy removeObjectIdenticalTo:object];
	return PS_AUTORELEASE([copy uniqueMembers]);
}

// http://en.wikipedia.org/wiki/Complement_(set_theory)
- (id)complementWithArray:(NSArray *)anArray {
	NSMutableArray __ps_autoreleasing *copy = [self mutableCopy];
	for (id object in self)
		if ([anArray containsObject:object])
			[copy removeObjectIdenticalTo:object];
	return PS_AUTORELEASE([copy uniqueMembers]);
}

- (id)complementWithSet:(NSSet *)anSet {
	NSMutableArray __ps_autoreleasing *copy = [self mutableCopy];
	for (id object in self)
		if ([anSet containsObject:object])
			[copy removeObjectIdenticalTo:object];
	return PS_AUTORELEASE([copy uniqueMembers]);
}

@end

@implementation NSArray (PSArrayResort)

- (id)arrayByReversing {
    NSMutableArray *resorted = [self mutableCopy];
    [resorted reverse];
    
    id ret = [[self class] arrayWithArray:resorted];
    
    PS_RELEASE_NIL(resorted);
    
    return ret;
}

- (id)arrayByShuffling {
    NSMutableArray *shuffled = [self mutableCopy];
    [shuffled shuffle];
    
    id ret = [[self class] arrayWithArray:shuffled];
    
    PS_RELEASE_NIL(shuffled);
    
    return ret;
}

@end

@implementation NSMutableArray (PSArrayResort)

- (void)reverse {
	for (int i=0; i<(floor([self count]/2.0)); i++)
		[self exchangeObjectAtIndex:i withObjectAtIndex:([self count]-(i+1))];    
}

// http://en.wikipedia.org/wiki/Knuth_shuffle
- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        NSUInteger m = 1;
        do {
            m <<= 1;
        } while (m < i);
        
        NSUInteger j;
        
        do {
            j = arc4random() % m;
        } while (j >= i);
        
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

- (void)scramble {
    [self shuffle];
}

@end

@implementation NSArray (PSArraySorting)

- (id)objectUsingPredicate:(NSPredicate *)predicate {
    NSArray *filteredArray = [self filteredArrayUsingPredicate:predicate];
    if (filteredArray)
        return [filteredArray firstObject];
    return nil;
}

- (NSArray *)arrayBySortingStrings {
    NSArray *sort = [self select:^BOOL(id obj) {
        return ([obj isKindOfClass:[NSString class]]);
    }];
	return [sort sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *)stringValue {
	return [self componentsJoinedByString:@" "];
}

@end