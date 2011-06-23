//
//  PRPScrollContentView.m
//  ScrollViewPins
//
//  Created by Matt Drance on 2/22/11.
//  Copyright 2011 Bookhouse Software LLC. All rights reserved.
//

#import "PSScrollContentView.h"

@interface PSScrollContentView ()
- (void)adjustSubviewsForTransform:(CGAffineTransform)transform;
@end

@implementation PSScrollContentView

@synthesize nonScalingSubviews;

- (void)dealloc {
    PS_RELEASE_NIL(nonScalingSubviews);
    PS_DEALLOC();
}

#pragma mark -
#pragma mark Accessors

- (NSMutableSet *)nonScalingSubviews {
    if (!nonScalingSubviews)
        nonScalingSubviews = [NSMutableSet new];
    
    return nonScalingSubviews;
}

- (void)addNonScalingSubview:(UIView *)view {
    [self.nonScalingSubviews addObject:view];
    [self addSubview:view];
}

#pragma mark -
#pragma mark (Non-)Scaling support

- (void)setTransform:(CGAffineTransform)transform {
    [super setTransform:transform];
    [self adjustSubviewsForTransform:transform];
}

- (void)adjustSubviewsForTransform:(CGAffineTransform)transform {
    CGAffineTransform inversion = CGAffineTransformInvert(transform);
    for (UIView *subview in self.nonScalingSubviews) {
        subview.transform = inversion;
    }
}

@end
