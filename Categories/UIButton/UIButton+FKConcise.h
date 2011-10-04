// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various shorthands to UIButton, for making life easier.
 */
@interface UIButton (FKConcise)

/**
 Creates a button of type "UIButtonTypeCustom" and sets the given image for UIControlStateNormal, and the size of the button
 to the size of the image.
 
 @param imageName the name of the image
 @return a button with type custom and the size of the given image
 */
+ (UIButton *)buttonWithImageNamed:(NSString *)imageName;

@end
