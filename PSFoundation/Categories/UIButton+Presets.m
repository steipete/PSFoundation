//
//  UIButton+Presets.m
//  PSFoundation
//
//  Created by Erik Aigner on 11/25/10.
//

#import "UIButton+Presets.h"
#import "UIButton+Glossy.h"

@implementation UIButton (Presets)

+ (UIButton *)alertButtonWithFrame:(CGRect)buttonFrame {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:buttonFrame];
  [button setBackgroundToGlossyRectOfColor:RGBCOLOR(200, 0, 0) withBorder:YES forState:UIControlStateNormal];
  [button setBackgroundToGlossyRectOfColor:RGBCOLOR(170, 0, 0) withBorder:YES forState:UIControlStateHighlighted];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setTitleShadowColor:[UIColor colorWithRed:.25 green:.25 blue:.25 alpha:1] forState:UIControlStateNormal];
  [[button titleLabel] setShadowOffset:CGSizeMake(0, -1)];
  [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:18.0]];

  return button;
}

@end
