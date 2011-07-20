//
//  NSArray+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

#import "NSArray+PSFoundation.h"

@implementation NSArray (PSFoundation)

- (BOOL)isEmpty {
    return (self.count == 0);
}

- (id)objectOrNilAtIndex:(NSUInteger)i {
    if (i >= self.count)
		return nil;
	return [self objectAtIndex:i];
}

+ (id)arrayWithSet:(NSSet*)set {
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:set.count];
    [set each:^(id sender) {
        [temp addObject:sender];
    }];
    id result = [[self class] arrayWithArray:temp];
    return result;
}

@end


@implementation NSMutableArray (PSFoundation)

- (void)moveObjectAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex {
	if (oldIndex == newIndex)
		return;
    
	id item = [self objectAtIndex:oldIndex];
    
	if (newIndex == self.count) {
		[self addObject:item];
		[self removeObjectAtIndex:oldIndex];
	} else {
        [item retain];
		[self removeObjectAtIndex:oldIndex];
		[self insertObject:item atIndex:newIndex];
        [item release];
	}
}

-(void)moveObject:(id)anObject toIndex:(NSUInteger)newIndex {
    NSUInteger index = [self indexOfObject:anObject];
    
    if (index == NSNotFound)
        return;
    
    return [self moveObjectAtIndex:index toIndex:newIndex];
}

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