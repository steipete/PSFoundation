//
//  NSArray+Structures.m
//  PSFoundation
//
//  Includes code by the following:
//   - Aleks Nesterow.  2010.  MIT.
//   - Pieter Omvlee.   2010.  Public domain.
//   - Erica Sadun.     2009.  Public domain.
//

#import "NSArray+Structures.h"
#import "NSArray+PSFoundation.h"

@implementation NSArray (PSArrayStructures)

- (id)firstObject {
    if (self.empty) return nil;
    return [self objectAtIndex:0];
}

@dynamic last;

@end

@implementation NSMutableArray (PSArrayStructures)

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

- (void)removeFirstObject {
    if (self.empty) return;
    
    [self removeObjectAtIndex:0];
}

@end
