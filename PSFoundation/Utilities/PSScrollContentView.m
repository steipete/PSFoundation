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

@synthesize nonScalingSubviews = nonScalingSubviews_;

- (void)dealloc {
    MCRelease(nonScalingSubviews_);
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSMutableSet *)nonScalingSubviews {
    if (nonScalingSubviews_ == nil) {
        nonScalingSubviews_ = [[NSMutableSet alloc] init];
    }
    
    return nonScalingSubviews_;
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
