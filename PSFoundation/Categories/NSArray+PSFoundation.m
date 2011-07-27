//
//  NSArray+PSFoundation.m
//  PSFoundation
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


- (id)firstObject {
    if (self.empty) return nil;
    return [self objectAtIndex:0];
}


@dynamic last;

@end