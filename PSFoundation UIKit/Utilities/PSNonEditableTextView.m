//
//  PSNonEditableTextView.m
//  PSFoundation
//
//  Created by Peter Steinberger on 19.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSNonEditableTextView.h"
#import <QuartzCore/QuartzCore.h>
#include "UIView+Sizes.h"
#import "NSObject+Utilities.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@implementation PSNonEditableTextView

+ (id)textViewForText:(NSString *)text {
  PSNonEditableTextView *textView = [PSNonEditableTextView new];
  textView.textColor = RGBCOLOR(76,86,108);
  textView.layer.shadowColor = [[UIColor whiteColor] CGColor];
  textView.layer.shadowOffset = CGSizeMake(1, 1);
  [textView.layer setShadowOpacity:1.0];
  [textView.layer setShadowRadius:0.3];
  textView.backgroundColor = [UIColor clearColor];
  textView.scrollEnabled = NO;
  textView.scrollsToTop = NO;
  textView.editable = NO;
  textView.textAlignment = UITextAlignmentCenter;

  textView.text = text;
  textView.font = [UIFont systemFontOfSize:14];

  CGSize size1 = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(300.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
  textView.height = size1.height + 10;

  return [textView autorelease];
}

- (BOOL)canBecomeFirstResponder {
  return NO;
}

@end
