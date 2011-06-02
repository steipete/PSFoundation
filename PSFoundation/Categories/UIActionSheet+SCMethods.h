//
//  UIActionSheet+SCMethods.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/25/10.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//	
//  References:
//   - http://github.com/eisernWolf/TouchCustoms
//

@interface UIActionSheet (SCMethods)

+ (void)showWithMessage:(NSString *)message fromTabBar:(UITabBar *)tabbar;
+ (void)showWithMessage:(NSString *)message fromToolbar:(UIToolbar *)toolbar;
+ (void)showWithMessage:(NSString *)message inView:(UIView *)view;

@end
