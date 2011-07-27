//
//  UIImage+Tint.h
//  PSFoundation
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//
//  References:
//   - http://mattgemmell.com/2010/07/05/mgimageutilities
//

@interface UIImage (MGTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

@end
