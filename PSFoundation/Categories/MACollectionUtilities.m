//
//  MACollectionUtilities.m
//  MACollectionUtilities
//
//  Created by Michael Ash on 10/11/10.
//  Copyright 2010 Michael Ash. All rights reserved.
//

#import "MACollectionUtilities.h"
#import "NSArray+BlocksKit.h"
#import "NSSet+BlocksKit.h"

@implementation NSArray (MACollectionUtilities)

- (NSArray *)ma_map: (id (^)(id obj))block {
    return [self map:block];
}

- (NSArray *)ma_select: (BOOL (^)(id obj))block {
    return [self select:block];
}

- (id)ma_match: (BOOL (^)(id obj))block {
    return [self match:block];
}

- (id)ma_reduce: (id)initial block: (id (^)(id a, id b))block {
    return [self reduce:initial withBlock:block];
}

@end

@implementation NSSet (MACollectionUtilities)

- (NSSet *)ma_map: (id (^)(id obj))block {
    return [self map:block];
}

- (NSSet *)ma_select: (BOOL (^)(id obj))block {
    return [self select:block];
}

- (id)ma_match: (BOOL (^)(id obj))block {
    return [self match:block];
}

@end
