//
//  UIView+MTAdditions.h
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
	MTUIViewAlignmentUnchanged,
	MTUIViewAlignmentLeftAligned,
	MTUIViewAlignmentRightAligned,
	MTUIViewAlignmentCenter
} MTUIViewAlignment;


@interface UIView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Properties for retreiving/changing of Frame Coordinates
//===========================================================

@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;

@property (nonatomic, assign) CGFloat frameLeft;
@property (nonatomic, assign) CGFloat frameTop;

@property (nonatomic, assign) CGFloat frameBottom;
@property (nonatomic, assign) CGFloat frameRight;


//===========================================================
#pragma mark -
#pragma mark Position Views
//===========================================================

// positions current view directly under the given view
- (void)positionUnderView:(UIView *)view;
// positions current view under a given view with a specified y-padding
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding;

// positions current view directly under the given view and aligns horizontally
- (void)positionUnderView:(UIView *)view alignment:(MTUIViewAlignment)alignment;
// positions current view under a given view with a specified y-padding and aligns horizontally
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(MTUIViewAlignment)alignment;

// adds the subview as a subview of the current view and centers it
- (void)addCenteredSubview:(UIView *)subview;
// moves the current view to the center of it's superview
- (void)moveToCenterOfSuperview;

//===========================================================
#pragma mark -
#pragma mark Rounded Corners
//===========================================================

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//===========================================================
#pragma mark -
#pragma mark Shadows
//===========================================================

- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

//===========================================================
#pragma mark -
#pragma mark Gradient Background
//===========================================================

- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
