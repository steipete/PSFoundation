//
//  UINavigationBar+CustomBackground.m
//  PSFoundation
//
//  Includes code by the following:
//   - Jonathan George.    2009.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

#import "UINavigationBar+CustomBackground.h"
#import "NSObject+AssociatedObjects.h"

@implementation UINavigationBar (CustomBackground)

static char *kNavigationBarBackgroundKey = "UINavigationBarCustomBackgroundImage";

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *background = [self associatedValueForKey:kNavigationBarBackgroundKey];
    if (!background && backgroundImage) {
        background = [[UIImageView alloc] initWithImage:backgroundImage];
        background.frame = self.bounds;
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:background];
        [self sendSubviewToBack:background];
        [self associateValue:background withKey:kNavigationBarBackgroundKey];
        [background release];
    } else if (background && !backgroundImage) {
        [background removeFromSuperview];
        [self associateValue:nil withKey:kNavigationBarBackgroundKey];
    } else {
        background.image = backgroundImage;
    }
}

- (UIImage *)backgroundImage {
    UIImageView *background = [self associatedValueForKey:kNavigationBarBackgroundKey];
    if (!background)
        return nil;
    else
        return [background image];
    [self sendSubviewToBack:background];
}


@end