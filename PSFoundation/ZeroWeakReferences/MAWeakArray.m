//
//  MAWeakArray.m
//  ZeroingWeakRef
//
//  Created by Mike Ash on 7/13/10.
//

#import "MAWeakArray.h"

#import "MAZeroingWeakRef.h"


@implementation MAWeakArray

- (id)init
{
    if((self = [super init]))
    {
        _weakRefs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_weakRefs release];
    [super dealloc];
}

- (NSUInteger)count
{
    return [_weakRefs count];
}

- (id)objectAtIndex: (NSUInteger)index
{
    return [[_weakRefs objectAtIndex: index] target];
}

- (void)addObject: (id)anObject
{
    [_weakRefs addObject: [MAZeroingWeakRef refWithTarget: anObject]];
}

- (void)insertObject: (id)anObject atIndex: (NSUInteger)index
{
    [_weakRefs insertObject: [MAZeroingWeakRef refWithTarget: anObject]
                    atIndex: index];
}

- (void)removeLastObject
{
    [_weakRefs removeLastObject];
}

- (void)removeObjectAtIndex: (NSUInteger)index
{
    [_weakRefs removeObjectAtIndex: index];
}

- (void)replaceObjectAtIndex: (NSUInteger)index withObject: (id)anObject
{
    [_weakRefs replaceObjectAtIndex: index
                         withObject: [MAZeroingWeakRef refWithTarget: anObject]];
}

@end
