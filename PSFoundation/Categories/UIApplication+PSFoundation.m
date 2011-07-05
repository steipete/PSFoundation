//
//  UIApplication+PSFoundation.h
//  PSFoundation
//
//  Created by Shaun Harrison.
//  Licensed under MIT; found in LICENSES/MIT
//

#import "UIApplication+PSFoundation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIApplication (PSFoundation)


- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated {
	[self setStatusBarStyle:style animated:animated];
    
	UIColor* newBackgroundColor = style == UIStatusBarStyleDefault ? [UIColor whiteColor] : [UIColor blackColor];
	UIColor* oldBackgroundColor = style == UIStatusBarStyleDefault ? [UIColor blackColor] : [UIColor whiteColor];
    
	if(animated) {
	    [CATransaction setValue:[NSNumber numberWithFloat:0.3] forKey:kCATransactionAnimationDuration];
        
		CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
		fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		fadeAnimation.fromValue = (__bridge id)oldBackgroundColor.CGColor;
		fadeAnimation.toValue = (__bridge id)newBackgroundColor.CGColor;
		fadeAnimation.fillMode = kCAFillModeForwards;
		fadeAnimation.removedOnCompletion = NO;
		[self.keyWindow.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
		[CATransaction commit];
	} else {
		self.keyWindow.backgroundColor = newBackgroundColor;
	}
}

@end
