//
//  UIView+MTAdditions.m
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import "UIView+MTUIAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Properties for retreiving/changing of Frame Coordinates
//===========================================================

- (void)setFrameWidth:(CGFloat)width
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setFrameHeight:(CGFloat)height
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setFrameTop:(CGFloat)top
{
	self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameLeft:(CGFloat)left
{
	self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameBottom:(CGFloat)bottom
{
	self.frame = CGRectMake(self.frame.origin.x,bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameRight:(CGFloat)right
{
	self.frame = CGRectMake(right - self.frame.size.width,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameHeight
{
	return self.frame.size.height;
}

- (CGFloat)frameWidth
{
	return self.frame.size.width;
}

- (CGFloat)frameTop
{
	return self.frame.origin.y;
}

- (CGFloat)frameLeft
{
	return self.frame.origin.x;
}

- (CGFloat)frameBottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)frameRight
{
	return self.frame.origin.x + self.frame.size.width;
}


//===========================================================
#pragma mark -
#pragma mark Position Views
//===========================================================

- (void)positionUnderView:(UIView *)view
{
	[self positionUnderView:view withPadding:0];
}

- (void)positionUnderView:(UIView *)view withPadding:(CGFloat)padding
{
	self.frameTop = view.frameBottom + padding;
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

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
	CALayer *l = [self layer];

	l.masksToBounds = YES;
	l.cornerRadius = cornerRadius;
	l.borderWidth = borderWidth;
	l.borderColor = [borderColor CGColor];
}


@end
