//
//  UIImageView+PSLib.h
//
//  Created by Peter Steinberger on 16.01.10.
//

@interface UIImageView(PSLib)

+ (UIImageView *)imageViewNamed:(NSString *)imageName;

- (void)setImage:(UIImage *)image animated:(BOOL)animated;
- (void)setImage:(UIImage *)image duration:(NSTimeInterval)duration;

@end
