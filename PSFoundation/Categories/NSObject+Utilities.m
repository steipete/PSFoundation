//
//  NSObject+Utilities.m
//  PSFoundation
//
//  Created by Peter Steinberger on 12.12.10.
//  Licensed under MIT. All rights reserved.
//

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

+ (id) make {
    return PS_AUTORELEASE([[[self class] alloc] init]);
}

- (void) performSelector: (SEL) selector afterDelay: (NSTimeInterval) delay {
	[self performSelector:selector withObject:nil afterDelay: delay];
}


@end
