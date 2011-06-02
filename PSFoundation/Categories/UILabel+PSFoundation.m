//
//  UILabel+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 02.05.10.
//  Licensed under MIT.  All rights reserved.
//

#import "UILabel+PSFoundation.h"

@implementation UILabel(PSLib)

+ (UILabel *)labelWithText:(NSString *)text {
  UILabel *label = [[[UILabel alloc] init] autorelease];
  label.text = text;
  return label;
}

@end
