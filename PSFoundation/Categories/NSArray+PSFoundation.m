//
//  NSArray+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

#import "NSArray+PSFoundation.h"

@implementation NSArray (PSFoundation)

+ (id)arrayWithAlphaNumericTitles {
	return [self arrayWithAlphaNumericTitlesWithSearch:NO];
}

+ (id)arrayWithAlphaNumericTitlesWithSearch:(BOOL)search {
	if (search)
        return [NSArray arrayWithObjects: @"{search}",
				@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
				@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
				@"W", @"X", @"Y", @"Z", @"#", nil];
	else
		return [NSArray arrayWithObjects:
				@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
				@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
				@"W", @"X", @"Y", @"Z", @"#", nil];
}

+ (id)arrayWithSet:(NSSet*)set {
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:set.count];
    [set each:^(id sender) {
        [temp addObject:sender];
    }];
    id result = [[[self class] alloc] initWithArray:temp];
    [temp release];
    return [result autorelease];
}

@end


@implementation NSMutableArray (PSFoundation)

- (void)moveObjectAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex {
	if (oldIndex == newIndex)
		return;
    
	id item = [self objectAtIndex:oldIndex];
    
	if (newIndex == [self count]) {
		[self addObject:item];
		[self removeObjectAtIndex:oldIndex];
	}
	else {
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

@end