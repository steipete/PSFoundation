//
//  MACollectionUtilities.m
//  MACollectionUtilities
//
//  Created by Michael Ash on 10/11/10.
//  Copyright 2010 Michael Ash. All rights reserved.
//

#import "MACollectionUtilities.h"


@implementation NSArray (MACollectionUtilities)

- (NSArray *)ma_map: (id (^)(id obj))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity: [self count]];
    for(id obj in self)
        [array addObject: block(obj)];
    return array;
}

- (NSArray *)ma_select: (BOOL (^)(id obj))block
{
    NSMutableArray *array = [NSMutableArray array];
    for(id obj in self)
        if(block(obj))
            [array addObject: obj];
    return array;
}

- (id)ma_match: (BOOL (^)(id obj))block
{
    for(id obj in self)
        if(block(obj))
            return obj;
    return nil;
}

- (id)ma_reduce: (id)initial block: (id (^)(id a, id b))block
{
    id a = initial;
    for(id b in self)
        a = block(a, b);
    return a;
}

@end

@implementation NSSet (MACollectionUtilities)

- (NSSet *)ma_map: (id (^)(id obj))block
{
    NSMutableSet *set = [NSMutableSet setWithCapacity: [self count]];
    for(id obj in self)
        [set addObject: block(obj)];
    return set;
}

- (NSSet *)ma_select: (BOOL (^)(id obj))block
{
    NSMutableSet *set = [NSMutableSet set];
    for(id obj in self)
        if(block(obj))
            [set addObject: obj];
    return set;
}

- (id)ma_match: (BOOL (^)(id obj))block
{
    for(id obj in self)
        if(block(obj))
            return obj;
    return nil;
}

@end
