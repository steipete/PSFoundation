//
//  UIActionSheet+SCMethods.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/25/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//	
//	Purpose
//	Extension methods for UIActionSheet.
//  http://github.com/eisernWolf/TouchCustoms , BSD

#import <UIKit/UIKit.h>

@interface UIActionSheet (SCMethods)

/**
 * There is often need to just show UIActionSheet with a custom message and OK button without providing a delegate
 * or any custom buttons.
 * 
 * @remarks
 *		The UIActionSheet creation method lets you keep the dialog localized in case you provide translation
 *		for "OK" string in your Localizable.strings file.
 */
+ (void)showWithMessage:(NSString *)message fromTabBar:(UITabBar *)tabbar;
+ (void)showWithMessage:(NSString *)message fromToolbar:(UIToolbar *)toolbar;
+ (void)showWithMessage:(NSString *)message inView:(UIView *)view;

@end
