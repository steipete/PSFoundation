//
//  UIView+PSAdditions.m
//  PSFoundation
//
//  Created by Peter Steinberger on 04.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "UIView+PSAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (PSAdditions)

- (void)enableDebugBorderWithColor:(UIColor *)color {
	DDLogInfo(@"enable debug for view %@", self);

	self.layer.borderColor = color.CGColor;
	self.layer.borderWidth = 2.0;
}

- (void)enableDebugBorder {
	[self enableDebugBorderWithColor:[UIColor orangeColor]];
}

@end
