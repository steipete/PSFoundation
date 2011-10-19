//
//  UIImageView+PSLib.m
//
//  Created by Peter Steinberger on 16.01.10.
//

#import "UIImageView+PSLib.h"

#define kPSFadeAnimationDuration    0.25

@implementation UIImageView (PSLib)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
  return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]] autorelease]; 
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    [self setImage:image duration:(animated ? kPSFadeAnimationDuration : 0.)];
}

- (void)setImage:(UIImage *)image duration:(NSTimeInterval)duration {
    if (duration > 0.) {
        CATransition *transition = [CATransition animation];
        
        transition.duration = duration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.layer addAnimation:transition forKey:nil];
    }
    
    self.image = image;
}

@end
