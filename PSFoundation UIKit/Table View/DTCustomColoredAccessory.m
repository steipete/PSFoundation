//
//  DTCustomColoredAccessory.m
//  PSFoundation
//
//  Created by Matthias Tretter on 09.03.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "DTCustomColoredAccessory.h"

@implementation DTCustomColoredAccessory

@synthesize accessoryColor;
@synthesize highlightedColor;
@synthesize type;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
    self.accessoryColor = nil;
    self.highlightedColor = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    
    const CGFloat R = 4.5;
    
    switch (self.type)
    {
        case DTCustomColoredAccessoryTypeRight:
        {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-3.0;;
            CGFloat y = CGRectGetMidY(self.bounds);
            
            CGContextMoveToPoint(ctxt, x-R, y-R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x-R, y+R);
            
            break;
        }
            
        case DTCustomColoredAccessoryTypeUp:
        {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.0;;
            CGFloat y = CGRectGetMinY(self.bounds)+5.0;
            
            CGContextMoveToPoint(ctxt, x-R, y+R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x+R, y+R);
            
            break;
        }
            
        case DTCustomColoredAccessoryTypeDown:
        {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.0;;
            CGFloat y = CGRectGetMaxY(self.bounds)-5.0;
            
            CGContextMoveToPoint(ctxt, x-R, y-R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x+R, y-R);
            
            break;
        }
            
            
        default:
            break;
    }
    
    CGContextSetLineCap(ctxt, kCGLineCapSquare);
    CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
    CGContextSetLineWidth(ctxt, 3);
    
	if (self.highlighted) {
		[self.highlightedColor setStroke];
	} else {
		[self.accessoryColor setStroke];
	}
    
	CGContextStrokePath(ctxt);
}

#pragma mark -
#pragma mark UIControl

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark DTCustomColoredAccessory

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color {
	return [self accessoryWithColor:color type:DTCustomColoredAccessoryTypeRight];
}

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color type:(DTCustomColoredAccessoryType)type {
    DTCustomColoredAccessory *accessory = [[DTCustomColoredAccessory alloc] initWithFrame:CGRectMake(0, 0, 15.0, 15.0)];
	accessory.accessoryColor = color;
    accessory.type = type;
    return [accessory autorelease];
}

- (UIColor *)accessoryColor {
	if (!accessoryColor) {
		return [UIColor blackColor];
	}
	return accessoryColor;
}

- (UIColor *)highlightedColor {
	if (!highlightedColor) {
		return [UIColor whiteColor];
	}
	return highlightedColor;
}

@end
