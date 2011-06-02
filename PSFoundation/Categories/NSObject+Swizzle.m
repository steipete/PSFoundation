//
//  NSObject+Swizzle.m
//  PSFoundation
//
//  Created by Peter Steinberger on 08.01.10.
//  Licensed under MIT. All rights reserved.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (PSSwizzling)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel error:(NSError**)error {
    return [self jr_swizzleMethod:origSel withMethod:newSel error:error];
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)newSel error:(NSError **)error {
    return [self jr_swizzleClassMethod:origSel withClassMethod:newSel error:error];
}

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector {
    [c jr_swizzleMethod:orig withMethod:newSelector error:nil];
}

@end
