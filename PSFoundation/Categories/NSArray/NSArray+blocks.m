//
//  NSString+blocks.m
//  blocks
//
//  Created by Robin Lu on 9/6/09.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "NSArray+blocks.h"


@implementation NSArray (BlockExtension)
- (void)each:(void (^)(id))block
{
    for (id obj in self) {
        block(obj);
    }
}

- (NSArray *)select:(BOOL (^)(id))block
{
    NSMutableArray *rslt = [NSMutableArray array];
    for (id obj in self) {
        if (block(obj)) {
            [rslt addObject:obj];
        }
    }
    return rslt;
}

- (NSArray *)map:(id (^)(id))block
{
    NSMutableArray *rslt = [NSMutableArray array];
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
