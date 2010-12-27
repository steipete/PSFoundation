//
//  UIView+MTAdditions.h
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


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

- (void)positionUnderView:(UIView *)view;
- (void)positionUnderView:(UIView *)view withPadding:(CGFloat)padding;
- (void)addCenteredSubview:(UIView *)subview;
- (void)moveToCenterOfSuperview;

//===========================================================
#pragma mark -
#pragma mark Rounded Corners
//===========================================================

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//===========================================================
#pragma mark -
#pragma mark Gradient Background
//===========================================================

- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor

@end
