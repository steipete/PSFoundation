//
//  UIScreen+PSAdditions.m
//  PSFoundation
//
//  Created by Peter Steinberger on 04.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "UIScreen+PSAdditions.h"

@implementation UIScreen (PSAdditions)

// http://stackoverflow.com/questions/2807339/uikeyboardboundsuserinfokey-is-deprecated-what-to-use-instead/2807367#2807367
+ (CGRect) convertRect:(CGRect)rect toView:(UIView *)view {
  UIWindow *window = [view isKindOfClass:[UIWindow class]] ? (UIWindow *) view : [view window];
  return [view convertRect:[window convertRect:rect fromWindow:nil] fromView:nil];
}

@end
