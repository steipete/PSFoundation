//
//  NSSet+blocks.m
//  BGCD
//
//  Created by Corey Floyd on 11/16/09.
//  Copyright 2009 Flying Jalapeño Software. All rights reserved.
//

#import "NSSet+blocks.h"


@implementation NSSet (BlockExtension)
- (void)each:(void (^)(id))block
{
    for (id obj in self) {
        block(obj);
    }
}

- (NSSet *)select:(BOOL (^)(id))block
{
    NSMutableSet *rslt = [NSMutableSet set];
    for (id obj in self) {
        if (block(obj)) {
            [rslt addObject:obj]; 
        }
    }
    return rslt;
}

- (NSSet *)map:(id (^)(id))block
{
    NSMutableSet *rslt = [NSMutableSet set];
    for (id obj in self) {
        [rslt addObject:block(obj)];
    }
    return rslt;
}

- (id)reduce:(id)initial withBlock:(id (^)(id,id))block
{
    id rslt = initial;
    for (id obj in self) {
        rslt = block(rslt, obj);
    }
    return rslt;
    
}
@end