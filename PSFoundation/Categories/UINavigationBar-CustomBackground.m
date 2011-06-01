//
//  UINavigationBar-CustomBackground.m
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "UINavigationBar-CustomBackground.h"

// use this instead?
// https://github.com/jdg/uinavigationbar-custom-background
@implementation UINavigationBar (CustomBackground)

// When the object is set up it calls drawRect, which then loads this method because of the method swizzling
- (void)drawRectCustomBackground:(CGRect)rect {

  // If the style of the bar is the default style, apply our custom visuals
  if (self.barStyle == UIBarStyleBlackOpaque) {

    // Create the drawing context
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // Set the background color of the navbar
    [[UIColor blackColor] set];
    CGRect fillRect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    CGContextFillRect(ctx, fillRect);

    // Create an instance of the image we want to draw
    UIImage * logo = [UIImage imageNamed:@"NavigationBar"];//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NavigationBar" ofType:@"png"]];

    // TODO: extract into pslib!
    /*
    if (UIDeviceOrientationIsLandscape([[AppDelegate getAppDelegate] interfaceOrientation])) {
      logo = [UIImage imageNamed:@"NavigationBarLandscape"];
    }
    */

    // Get the absolute center points relative to the image and the screen
    NSNumber * centerX = [NSNumber numberWithFloat:(self.frame.size.width/2 - logo.size.width/2)];
    NSNumber * centerY = [NSNumber numberWithFloat:(self.frame.size.height/2 - logo.size.height/2)];

    // Draw the image
    [logo drawInRect:CGRectMake(centerX.floatValue, centerY.floatValue, logo.size.width, logo.size.height)];

    // End execution of the method
    return;
  }

  // By this time drawRectCustomBackground is actually referencing to drawRect
  [self drawRectCustomBackground:rect];
}


@end
