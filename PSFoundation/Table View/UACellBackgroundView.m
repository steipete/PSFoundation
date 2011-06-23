//
//  UACellBackgroundView.m
//  PSFoundation
//
//  Created by Matt Coneybeare on 1/31/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//  Code from http://gist.github.com/292384
//

#define TABLE_CELL_BACKGROUND    { 1, 1, 1, 1, 0.866, 0.866, 0.866, 1}			// #FFFFFF and #DDDDDD
#define kDefaultMargin           10

#import "UACellBackgroundView.h"

@implementation UACellBackgroundView

@synthesize position, backgroundImage;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		CGFloat tempColorComponents[8] = TABLE_CELL_BACKGROUND;

		for (int i=0;i<8;i++) {
			colorComponents_[i] =  tempColorComponents[i];
		}
	}

	return self;
}

- (void)dealloc {
	PS_RELEASE_NIL(backgroundImage);
    PS_DEALLOC();
}

- (BOOL) isOpaque {
	return NO;
}

-(void)drawRect:(CGRect)aRect {
	CGContextRef c = UIGraphicsGetCurrentContext();

	int lineWidth = 1;

	CGRect rect = [self bounds];
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	miny -= 1;

	CGFloat locations[2] = { 0.0, 1.0 };
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient = nil;
	CGContextSetStrokeColorWithColor(c, [[UIColor grayColor] CGColor]);
	CGContextSetLineWidth(c, lineWidth);
	CGContextSetAllowsAntialiasing(c, YES);
	CGContextSetShouldAntialias(c, YES);

	if (position == UACellBackgroundViewPositionTop) {
		miny += 1;

		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minx, maxy);
		CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, kDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, maxy, kDefaultMargin);
		CGPathAddLineToPoint(path, NULL, maxx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, maxy);
		CGPathCloseSubpath(path);

		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		myGradient = CGGradientCreateWithColorComponents(myColorspace, colorComponents_, locations, 2);
		CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);

		[self.backgroundImage drawInRect:[self bounds]];

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);

	} else if (position == UACellBackgroundViewPositionBottom) {
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minx, miny);
		CGPathAddArcToPoint(path, NULL, minx, maxy, midx, maxy, kDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, maxy, maxx, miny, kDefaultMargin);
		CGPathAddLineToPoint(path, NULL, maxx, miny);
		CGPathAddLineToPoint(path, NULL, minx, miny);
		CGPathCloseSubpath(path);

		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		myGradient = CGGradientCreateWithColorComponents(myColorspace, colorComponents_, locations, 2);
		CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);

		[self.backgroundImage drawInRect:[self bounds]];

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);


	} else if (position == UACellBackgroundViewPositionMiddle) {
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minx, miny);
		CGPathAddLineToPoint(path, NULL, maxx, miny);
		CGPathAddLineToPoint(path, NULL, maxx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, miny);
		CGPathCloseSubpath(path);

		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		myGradient = CGGradientCreateWithColorComponents(myColorspace, colorComponents_, locations, 2);
		CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);

		[self.backgroundImage drawInRect:[self bounds]];

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);

	} else if (position == UACellBackgroundViewPositionSingle) {
		miny += 1;

		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, minx, midy);
		CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, kDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, kDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, kDefaultMargin);
		CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, kDefaultMargin);
		CGPathCloseSubpath(path);

		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);

		myGradient = CGGradientCreateWithColorComponents(myColorspace, colorComponents_, locations, 2);
		CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);

		[self.backgroundImage drawInRect:[self bounds]];

		CGContextAddPath(c, path);
		CGPathRelease(path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);
	}

	CGColorSpaceRelease(myColorspace);
	CGGradientRelease(myGradient);
}

- (void)setPosition:(UACellBackgroundViewPosition)newPosition {
	if (position != newPosition) {
		position = newPosition;
		[self setNeedsDisplay];
	}
}

- (void)setColorComponents:(CGFloat *)colorComponents {
	for (int i=0;i<8;i++) {
		colorComponents_[i] = colorComponents[i];
	}
}

@end