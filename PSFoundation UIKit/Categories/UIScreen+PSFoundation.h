//
//  UIScreen+PSFoundation.h
//  PSFoundation
//
//  Created by Peter Steinberger on 04.12.10.
//  Licensed under MIT.  All rights reserved.
//
//  References:
//   - http://stackoverflow.com/questions/2807339/uikeyboardboundsuserinfokey-is-deprecated-what-to-use-instead/2807367#2807367
//

@interface UIScreen (PSFoundation)

+ (CGRect) convertRect:(CGRect)rect toView:(UIView *)view;

@end
