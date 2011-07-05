//
//  GradientView.m
//  ShadowedTableView
//
//  Created by Matt Gallagher on 2009/08/21.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//

#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GradientView

+ (Class)layerClass {
	return [CAGradientLayer class];
}

- (void)setupGradientLayer {
	CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    
    gradientLayer.colors = ARRAY((__bridge id)[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0].CGColor,
                                 (__bridge id)[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor);
    
	self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setupGradientLayer];
    }
    return self;
}

@end
