//
//  NSMutableArray+MTShuffle.m
//  MTHelper
//
//  Created by Matthias Tretter on 31.10.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import "NSMutableArray+MTShuffle.h"


// Unbiased random rounding thingy.
static NSUInteger random_below(NSUInteger n) {
    NSUInteger m = 1;
	
    do {
        m <<= 1;
    } while(m < n);
	
    NSUInteger ret;
	
    do {
        ret = arc4random() % m;
    } while(ret >= n);
	
    return ret;
}

@implementation NSMutableArray (MTShuffle)

- (void)shuffle {
    // http://en.wikipedia.org/wiki/Knuth_shuffle
	
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = random_below(i);
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

@end
