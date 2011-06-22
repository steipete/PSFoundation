//
//  UIView+MTAdditions.m
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import "UIView+MTUIAdditions.h"
#include "UIView+Sizes.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Properties for retreiving/changing of Frame Coordinates
//===========================================================

- (void)setFrameWidth:(CGFloat)width {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setFrameHeight:(CGFloat)height {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setFrameTop:(CGFloat)top {
	self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameLeft:(CGFloat)left {
	self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameBottom:(CGFloat)bottom {
	self.frame = CGRectMake(self.frame.origin.x,bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameRight:(CGFloat)right {
	self.frame = CGRectMake(right - self.frame.size.width,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameHeight {
	return self.frame.size.height;
}

- (CGFloat)frameWidth {
	return self.frame.size.width;
}

- (CGFloat)frameTop {
	return self.frame.origin.y;
}

- (CGFloat)frameLeft {
	return self.frame.origin.x;
}

- (CGFloat)frameBottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)frameRight {
	return self.frame.origin.x + self.frame.size.width;
}


//===========================================================
#pragma mark -
#pragma mark Position Views
//===========================================================

- (void)positionUnderView:(UIView *)view {
	[self positionUnderView:view padding:0];
}

- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding {
	[self positionUnderView:view padding:padding alignment:MTUIViewAlignmentUnchanged];
}

- (void)positionUnderView:(UIView *)view alignment:(MTUIViewAlignment)alignment {
	[self positionUnderView:view padding:0 alignment:alignment];
}

- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(MTUIViewAlignment)alignment {
	self.frameTop = view.frameBottom + padding;

	switch (alignment) {
		case MTUIViewAlignmentUnchanged:
			// do nothing
			break;
		case MTUIViewAlignmentLeftAligned:
			self.frameLeft = view.frameLeft;
			break;

		case MTUIViewAlignmentRightAligned:
			self.frameRight = view.frameRight;
			break;

		case MTUIViewAlignmentCenter:
			self.centerX = view.centerX;
			break;
	}
}

- (void)addCenteredSubview:(UIView *)subview {
	subview.frameLeft = (CGFloat)((self.bounds.size.width - subview.frameWidth) / 2);
	subview.frameTop = (CGFloat)((self.bounds.size.height - subview.frameHeight) / 2);

	[self addSubview:subview];
}

- (void)moveToCenterOfSuperview {
	self.frameLeft = (CGFloat)((self.superview.bounds.size.width - self.frameWidth) / 2);
	self.frameTop = (CGFloat)((self.superview.bounds.size.height - self.frameHeight) / 2);
}


//===========================================================
#pragma mark -
#pragma mark Rounded Corners
//===========================================================

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
	CALayer *l = [self layer];

	l.masksToBounds = YES;
	l.cornerRadius = cornerRadius;
	l.borderWidth = borderWidth;
	l.borderColor = [borderColor CGColor];
}

//===========================================================
#pragma mark -
#pragma mark Shadows
//===========================================================

- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
	self.layer.masksToBounds = NO;
	self.layer.shadowOffset = offset;
	self.layer.shadowRadius = radius;
	self.layer.shadowOpacity = opacity;
}

//===========================================================
#pragma mark -
#pragma mark Gradient Background
//===========================================================

- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
	CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.bounds;
    
    CFArrayRef colors = CFARRAY([startColor CGColor], [endColor CGColor]);
    
    gradient.colors = objc_unretainedObject(colors);
    
    CFRelease(colors);

	[self.layer insertSublayer:gradient atIndex:0];
}

@end
