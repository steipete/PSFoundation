//
//  PSShadowView.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSShadowView.h"

#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)

@interface PSShadowView ()
@property (nonatomic, retain) CAGradientLayer *topShadowLayer;
@property (nonatomic, retain) CAGradientLayer *bottomShadowLayer;
@end

@implementation PSShadowView

@synthesize topShadowLayer, bottomShadowLayer, topShadow, bottomShadow;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark static

+ (PSShadowView *)viewWithSubview:(UIView *)view {
    PSShadowView *shadowView = [[[[self class] alloc] init] autorelease];
    shadowView.topShadow = YES;
    shadowView.bounds = view.bounds;
    shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [shadowView addSubview:view];
    return shadowView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private

// borrowed from ShadowTableView
+ (CAGradientLayer *)shadowAsInverse:(BOOL)inverse {
    CAGradientLayer *newShadow = [CAGradientLayer layer];
    
	CGColorRef darkColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:
                            inverse ? (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT) * 0.6 : 0.6].CGColor;
	CGColorRef lightColor = [UIColor clearColor].CGColor;
    
    CFArrayRef colors = CFARRAY((inverse ? lightColor : darkColor),
                                (inverse ? darkColor : lightColor));
    
    newShadow.colors = objc_unretainedObject(colors);
    
    CFRelease(colors);

	return newShadow;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (void)dealloc {
    self.topShadowLayer = nil;
    self.bottomShadowLayer = nil;

  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

- (void)setFrame:(CGRect)rect {
    [super setFrame:rect];
    [self setNeedsDisplay];
}

// layoutSubviews
//
// Override to layout the shadows
//
- (void)layoutSubviews {
	[super layoutSubviews];

    if (self.isTopShadow) {
        if (!self.topShadowLayer) {
            self.topShadowLayer = [PSShadowView shadowAsInverse:YES];
            [self.layer addSublayer:self.topShadowLayer];
        } else if ([self.layer.sublayers indexOfObjectIdenticalTo:self.topShadowLayer] != 0) {
            [self.layer addSublayer:self.topShadowLayer];
        }
        self.topShadowLayer.frame = CGRectMake(0, -SHADOW_INVERSE_HEIGHT, self.frame.size.width, SHADOW_INVERSE_HEIGHT);
    } else {
        [self.topShadowLayer removeFromSuperlayer];
        self.topShadowLayer = nil;
    }


    if (self.isBottomShadow) {
        if (!self.bottomShadowLayer) {
            self.bottomShadowLayer = [PSShadowView shadowAsInverse:NO];
            [self.layer insertSublayer:self.bottomShadowLayer atIndex:0];
        } else if ([self.layer.sublayers indexOfObjectIdenticalTo:self.bottomShadowLayer] != 0) {
            [self.layer insertSublayer:self.bottomShadowLayer atIndex:0];
        }
        self.bottomShadowLayer.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, SHADOW_HEIGHT);
    } else {
        [self.bottomShadowLayer removeFromSuperlayer];
        self.bottomShadowLayer = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

- (void)setTopShadow:(BOOL)flag {
    topShadow = flag;
    [self setNeedsLayout];
}

- (void)setBottomShadow:(BOOL)flag {
    bottomShadow = flag;
    [self setNeedsLayout];
}

@end
