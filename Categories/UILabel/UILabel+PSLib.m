//
//  UILabel+PSLib.m
//
//  Created by Peter Steinberger on 02.05.10.
//

#import "UILabel+PSLib.h"

@implementation UILabel(PSLib)

+ (UILabel *)labelWithText:(NSString *)text {
  UILabel *label = [[[UILabel alloc] init] autorelease];
  label.text = text;
  return label;
}

@end
