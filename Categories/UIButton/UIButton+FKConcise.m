#import "UIButton+FKConcise.h"

@implementation UIButton (FKConcise)

+ (UIButton *)buttonWithImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = nil;
    
    if (image != nil) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect){CGPointZero,image.size};
        [button setImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

@end
