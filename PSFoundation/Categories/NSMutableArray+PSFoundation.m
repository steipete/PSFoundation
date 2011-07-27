//
//  NSMutableArray+PSFoundation.m
//  PSFoundation
//

#import "NSMutableArray+PSFoundation.h"
#import "NSArray+PSFoundation.h"

@implementation NSMutableArray (PSFoundation)

- (void)removeFirstObject {
    if (self.empty) return;
    
    [self removeObjectAtIndex:0];
}


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


- (void)enqueue:(id)object {
	[self insertObject:object atIndex:0];
}


- (id)dequeue {
	if (self.empty) return nil;
    
    id lastObject = [[self lastObject] retain];
	[self removeLastObject];
	return [lastObject autorelease];
}


- (void)push:(id)object {
    [self addObject:object];
}


- (id)pull {
	if (self.empty) return nil;
    
    id firstObject = [[self firstObject] retain];
	[self removeObjectAtIndex:0];
	return [firstObject autorelease];
}


- (id)pop {
	return [self dequeue];
}

@end