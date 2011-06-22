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
    
    CFArrayRef colors = CFARRAY([UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor,
                                [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor);
    
    gradientLayer.colors = objc_unretainedObject(colors);
    
    CFRelease(colors);
    
	self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setupGradientLayer];
    }
    return self;
}

@end
