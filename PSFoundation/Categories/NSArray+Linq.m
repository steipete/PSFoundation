//
//  NSArray+Linq.m
//  PSFoundation
//
//  Created by Aleks Nesterow on 8/10/10.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

#import "NSArray+Linq.h"
#import "NSArray+BlocksKit.h"

@implementation NSArray (Linq)

+ (id)aggregate:(NSArray *)array usingBlock:(id (^)(id accumulator, id currentItem))block {
    return [array reduce:nil withBlock:block];
}

- (id)aggregateUsingBlock:(id (^)(id accumulator, id currentItem))block {
    return [self reduce:nil withBlock:block];}

+ (NSArray *)select:(NSArray *)array usingBlock:(id (^)(id currentItem))block {
    return [array map:block];
}

- (NSArray *)selectUsingBlock:(id (^)(id currentItem))block {
    return [self map:block];
}

@end
