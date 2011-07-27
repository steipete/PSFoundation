//
//  ButtonGradientView.m
//  Custom Alert View
//
//  Created by jeff on 5/17/10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "GradientButton.h"
#import "NSObject+BlocksKit.h"

@interface GradientButton()

@property (nonatomic, readonly) CGGradientRef normalGradient;
@property (nonatomic, readonly) CGGradientRef highlightGradient;

@end

#pragma mark -

@implementation GradientButton

@synthesize normalGradientColors, normalGradientLocations;
@synthesize highlightGradientColors, highlightGradientLocations;
@synthesize cornerRadius, style;
@synthesize strokeWeight, strokeColor;

#pragma mark -

- (CGGradientRef)normalGradient {
    if (normalGradient == NULL) {
        
        NSUInteger locCount = normalGradientLocations.count;
        CGFloat locations[locCount];
        for (int i = 0; i < locCount; i++)
        {
            NSNumber *location = [normalGradientLocations objectAtIndex:i];
            locations[i] = [location floatValue];
        }
        
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        normalGradient = CGGradientCreateWithColors(space, (CFArrayRef)normalGradientColors, locations);
        CGColorSpaceRelease(space);
    }
    return normalGradient;
}

- (CGGradientRef)highlightGradient {
    if (highlightGradient == NULL) {
        
        NSUInteger locCount = highlightGradientLocations.count;
        CGFloat locations[locCount];
        for (int i = 0; i < locCount; i++)
        {
            NSNumber *location = [highlightGradientLocations objectAtIndex:i];
            locations[i] = [location floatValue];
        }
        
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        highlightGradient = CGGradientCreateWithColors(space, (CFArrayRef)highlightGradientColors, locations);
        CGColorSpaceRelease(space);
    }
    return highlightGradient;
}

#pragma mark -
#pragma mark Appearances

- (void)setStyle:(PSGradientButtonStyle)aStyle {
    if (aStyle != style) {
        style = aStyle;
        
        CFArrayRef normalColors = NULL, highlightColors = NULL;
        
        switch (aStyle) {
            default: case GradientButtonCustomStyle:
                self.normalGradientColors = nil;
                self.highlightGradientColors = nil; 
                self.normalGradientLocations = nil;
                self.highlightGradientLocations = nil;
            break;
                
            case GradientButtonAlertStyle: {
                normalColors =    CFARRAY(PSCGColor(72, 82, 106),
                                          PSCGColor(209, 213, 222),
                                          PSCGColor(47, 57, 83) );
                highlightColors = CFARRAY(PSCGColor(0, 0, 0),
                                          PSCGColor(167, 174, 182),
                                          PSCGColor(35, 40, 53),
                                          PSCGColor(60, 66, 78) );
                
                self.normalGradientLocations =    ARRAY([NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1], [NSNumber numberWithFloat:0.483]);
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1],
                                                        [NSNumber numberWithFloat:0.51f], [NSNumber numberWithFloat:0.654f]);
                break;
            }
            case GradientButtonDestructiveStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.667 green:0.15 blue:0.152 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.841 green:0.566 blue:0.566 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.75 green:0.341 blue:0.345 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.592 green:0.0 blue:0.0 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.592 green:0.0 blue:0.0 alpha:1.0].CGColor
                );
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.467 green:0.009 blue:0.005 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.754 green:0.562 blue:0.562 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.543 green:0.212 blue:0.212 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.5 green:0.153 blue:0.152 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.388 green:0.004 blue:0.0 alpha:1.0].CGColor
                );
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                     [NSNumber numberWithFloat:0.582f], [NSNumber numberWithFloat:0.418f],
                                                     [NSNumber numberWithFloat:0.346]);
                
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.715f], [NSNumber numberWithFloat:0.513f],
                                                        [NSNumber numberWithFloat:0.445f]);
                break;
            }
            case GradientButtonWhiteStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.864 green:0.864 blue:0.864 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.995 green:0.995 blue:0.995 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.956 green:0.956 blue:0.955 alpha:1.0].CGColor
                );
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.692 green:0.692 blue:0.691 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.995 green:0.995 blue:0.995 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0].CGColor
                );
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1], [NSNumber numberWithFloat:0.601f]);
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1], [NSNumber numberWithFloat:0.601f]);
                
                break;
            }
            case GradientButtonBlackStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.154 green:0.154 blue:0.154 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.307 green:0.307 blue:0.307 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.166 green:0.166 blue:0.166 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.118 green:0.118 blue:0.118 alpha:1.0].CGColor
                );
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.199 green:0.199 blue:0.199 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.040 green:0.040 blue:0.040 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.074 green:0.074 blue:0.074 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.112 green:0.112 blue:0.112 alpha:1.0].CGColor
                );
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                     [NSNumber numberWithFloat:0.548f], [NSNumber numberWithFloat:0.462f]);
                
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.548f], [NSNumber numberWithFloat:0.462f]);
                
                break;
            }
            case GradientButtonWhiteActionStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.864 green:0.864 blue:0.864 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.995 green:0.995 blue:0.995 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.956 green:0.956 blue:0.955 alpha:1.0].CGColor
                );
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.033 green:0.251 blue:0.673 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.660 green:0.701 blue:0.880 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.222 green:0.308 blue:0.709 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.145 green:0.231 blue:0.683 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.000 green:0.124 blue:0.621 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.011 green:0.181 blue:0.647 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.311 green:0.383 blue:0.748 alpha:1.0].CGColor
                );
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1], [NSNumber numberWithFloat:0.601]);
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.957f], [NSNumber numberWithFloat:0.574f],
                                                        [NSNumber numberWithFloat:0.541f], [NSNumber numberWithFloat:0.185f],
                                                        [NSNumber numberWithFloat:0.812f]);
                
                break;
            }
            case GradientButtonBlackActionStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.154 green:0.154 blue:0.154 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.307 green:0.307 blue:0.307 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.166 green:0.166 blue:0.166 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.118 green:0.118 blue:0.118 alpha:1.0].CGColor);
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.033 green:0.251 blue:0.673 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.660 green:0.701 blue:0.880 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.222 green:0.308 blue:0.709 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.145 green:0.231 blue:0.683 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.000 green:0.124 blue:0.621 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.011 green:0.181 blue:0.647 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.311 green:0.383 blue:0.748 alpha:1.0].CGColor);    
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                     [NSNumber numberWithFloat:0.548f], [NSNumber numberWithFloat:0.462f]);
                
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.957f], [NSNumber numberWithFloat:0.574f],
                                                        [NSNumber numberWithFloat:0.541], [NSNumber numberWithFloat:0.185],
                                                        [NSNumber numberWithFloat:0.812f]);

                break;
            }

            case GradientButtonOrangeStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.935 green:0.403 blue:0.02 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.97 green:0.582 blue:0.0 alpha:1.0].CGColor);
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.914 green:0.309 blue:0.00 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.935 green:0.400 blue:0.00 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.946 green:0.441 blue:0.01 alpha:1.0].CGColor);
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f]);
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.498f]);
                
                break;
            }

            case GradientButtonConfirmStyle: {
                normalColors = CFARRAY(
                    [UIColor colorWithRed:0.150 green:0.667 blue:0.152 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.566 green:0.841 blue:0.566 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.341 green:0.750 blue:0.345 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.000 green:0.592 blue:0.000 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.000 green:0.592 blue:0.000 alpha:1.0].CGColor
                );
                
                highlightColors = CFARRAY(
                    [UIColor colorWithRed:0.009 green:0.467 blue:0.005 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.562 green:0.754 blue:0.562 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.212 green:0.543 blue:0.212 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.153 green:0.500 blue:0.152 alpha:1.0].CGColor,
                    [UIColor colorWithRed:0.004 green:0.388 blue:0.000 alpha:1.0].CGColor
                );
                
                self.normalGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                     [NSNumber numberWithFloat:0.582f], [NSNumber numberWithFloat:0.418f],
                                                     [NSNumber numberWithFloat:0.346]);
                
                self.highlightGradientLocations = ARRAY([NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:1.0f],
                                                        [NSNumber numberWithFloat:0.715f], [NSNumber numberWithFloat:0.513f],
                                                        [NSNumber numberWithFloat:0.445f]);
                
                break;
            }
        }
        
        if (normalColors) {
            self.normalGradientColors = (NSArray *)normalColors;
            CFRelease(normalColors);
        }
        
        if (highlightColors) {
            self.highlightGradientColors = (NSArray *)highlightColors;
            CFRelease(highlightColors);
        }
            
        UIColor *normalTextColor = [UIColor whiteColor],
                *highlightTextColor = [UIColor whiteColor];
        
        if (aStyle == GradientButtonWhiteStyle) {
            normalTextColor = [UIColor blackColor];
            highlightTextColor = [UIColor darkGrayColor];
        } else if (aStyle == GradientButtonWhiteActionStyle) {
            normalTextColor = [UIColor blackColor];
        }
        
        [self setTitleColor:normalTextColor forState:UIControlStateNormal];
        [self setTitleColor:highlightTextColor forState:UIControlStateHighlighted];
        
        self.cornerRadius = (aStyle == GradientButtonAlertStyle) ? 7.0f : 9.0f;
    }
}

#pragma mark -
- (void)drawRect:(CGRect)rect {
	CGRect imageBounds = CGRectMake(0.0, 0.0, self.bounds.size.width - 0.5, self.bounds.size.height);

	CGGradientRef gradient;
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGPoint point2;

	CGFloat resolution = 0.5 * (self.bounds.size.width / imageBounds.size.width + self.bounds.size.height / imageBounds.size.height);

	CGFloat stroke = strokeWeight * resolution;
	if (stroke < 1.0)
		stroke = ceil(stroke);
	else
		stroke = round(stroke);
	stroke /= resolution;
	CGFloat alignStroke = fmod(0.5 * stroke * resolution, 1.0);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPoint point = CGPointMake((self.bounds.size.width - [self cornerRadius]), self.bounds.size.height - 0.5f);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(self.bounds.size.width - 0.5f, (self.bounds.size.height - [self cornerRadius]));
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPoint controlPoint1 = CGPointMake((self.bounds.size.width - ([self cornerRadius] / 2.f)), self.bounds.size.height - 0.5f);
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	CGPoint controlPoint2 = CGPointMake(self.bounds.size.width - 0.5f, (self.bounds.size.height - ([self cornerRadius] / 2.f)));
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(self.bounds.size.width - 0.5f, [self cornerRadius]);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake((self.bounds.size.width - [self cornerRadius]), 0.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(self.bounds.size.width - 0.5f, ([self cornerRadius] / 2.f));
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake((self.bounds.size.width - ([self cornerRadius] / 2.f)), 0.0);
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake([self cornerRadius], 0.0);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(0.0, [self cornerRadius]);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(([self cornerRadius] / 2.f), 0.0);
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake(0.0, ([self cornerRadius] / 2.f));
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake(0.0, (self.bounds.size.height - [self cornerRadius]));
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	point = CGPointMake([self cornerRadius], self.bounds.size.height - 0.5f);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	controlPoint1 = CGPointMake(0.0, (self.bounds.size.height - ([self cornerRadius] / 2.f)));
	controlPoint1.x = (round(resolution * controlPoint1.x + alignStroke) - alignStroke) / resolution;
	controlPoint1.y = (round(resolution * controlPoint1.y + alignStroke) - alignStroke) / resolution;
	controlPoint2 = CGPointMake(([self cornerRadius] / 2.f), self.bounds.size.height - 0.5f);
	controlPoint2.x = (round(resolution * controlPoint2.x + alignStroke) - alignStroke) / resolution;
	controlPoint2.y = (round(resolution * controlPoint2.y + alignStroke) - alignStroke) / resolution;
	CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
	point = CGPointMake((self.bounds.size.width - [self cornerRadius]), self.bounds.size.height - 0.5f);
	point.x = (round(resolution * point.x + alignStroke) - alignStroke) / resolution;
	point.y = (round(resolution * point.y + alignStroke) - alignStroke) / resolution;
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	CGPathCloseSubpath(path);
    if (self.state == UIControlStateHighlighted)
        gradient = self.highlightGradient;
    else
        gradient = self.normalGradient;

	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	point = CGPointMake((self.bounds.size.width / 2.0), self.bounds.size.height - 0.5f);
	point2 = CGPointMake((self.bounds.size.width / 2.0), 0.0);
	CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	CGContextRestoreGState(context);
	[strokeColor setStroke];
	CGContextSetLineWidth(context, stroke);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGPathRelease(path);

}

- (void)setOpaque:(BOOL)opaque {
    [super setOpaque:NO];
}

- (BOOL)isOpaque {
    return NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

- (UIColor *)backgroundColor {
    return [UIColor clearColor];
}

#pragma mark -
#pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [NSObject performBlock:^(void) {
        [self setNeedsDisplay];
    } afterDelay:0.1];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [NSObject performBlock:^(void) {
        [self setNeedsDisplay];
    } afterDelay:0.1];}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];

    [encoder encodeObject:self.normalGradientColors forKey:@"normalGradientColors"];
    [encoder encodeObject:self.normalGradientLocations forKey:@"normalGradientLocations"];
    [encoder encodeObject:self.highlightGradientColors forKey:@"highlightGradientColors"];
    [encoder encodeObject:self.highlightGradientLocations forKey:@"highlightGradientLocations"];
    [encoder encodeObject:self.strokeColor forKey:@"strokeColor"];
    [encoder encodeObject:[NSNumber numberWithFloat:self.strokeWeight] forKey:@"strokeWeight"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        self.normalGradientColors = [decoder decodeObjectForKey:@"normalGradientColors"];
        self.highlightGradientColors = [decoder decodeObjectForKey:@"highlightGradientColors"];
        self.normalGradientLocations = [decoder decodeObjectForKey:@"normalGradientLocations"];
        self.highlightGradientLocations = [decoder decodeObjectForKey:@"highlightGradientLocations"];
        self.strokeWeight = [[decoder decodeObjectForKey:@"strokeWeight"] floatValue];
        self.strokeColor = [decoder decodeObjectForKey:@"strokeColor"];

        if (!self.normalGradientColors)
            self.style = GradientButtonWhiteStyle;
    }
    return self;
}

#pragma mark -

- (void)dealloc {
    if (normalGradient != NULL)
        CGGradientRelease(normalGradient);
    if (highlightGradient != NULL)
        CGGradientRelease(highlightGradient);
    
    self.normalGradientColors = nil;
    self.highlightGradientColors = nil;
    self.normalGradientLocations = nil;
    self.highlightGradientLocations = nil;
    self.strokeColor = nil;
    
    [super dealloc];
}

@end
