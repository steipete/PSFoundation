//
//  UIScreen+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 04.12.10.
//  Licensed under MIT.  All rights reserved.
//

#import "UIScreen+PSFoundation.h"

@implementation UIScreen (PSFoundation)

+ (CGRect) convertRect:(CGRect)rect toView:(UIView *)view {
  UIWindow *window = [view isKindOfClass:[UIWindow class]] ? (UIWindow *) view : [view window];
  return [view convertRect:[window convertRect:rect fromWindow:nil] fromView:nil];
}

@end
