//
//  PSGradientView.m
//  PSFoundation
//
//  Includes code by the following:
//   - Matt Gallagher.    2009. Public domain.
//   - Sam Soffes.        2011. Public domain.
//   - Zachary Waldowski. 2011. MIT.
//

#import "PSGradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PSGradientView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
        
        gradientLayer.colors = ARRAY((id)[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0].CGColor,
                                     (id)[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor);
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (Class)layerClass {
	return [CAGradientLayer class];
}

- (void)setColors:(NSArray *)colors {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    gradientLayer.colors = colors;
}

- (NSArray *)colors {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    return gradientLayer.colors;
}

- (void)setLocations:(NSArray *)locations {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    gradientLayer.locations = locations;
}

- (NSArray *)locations {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    return gradientLayer.locations;    
}

- (void)setHorizontal:(BOOL)isHorizontal {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
    if (isHorizontal) {
        gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    } else {
        gradientLayer.startPoint = CGPointMake(0.5, 0.0);
        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    }
}

@synthesize horizontal;

@end
