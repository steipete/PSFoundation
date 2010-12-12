//
//  UIAlertView+SCMethods.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/14/10.
//	aleks.nesterow@gmail.com
//
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//
//	Purpose
//	Extension methods for UIAlertView.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SCMethods)

/**
  * Uses [error localizedFailureReason] as UIAlertView title and [error localizedDescription] as its message.
  *
  * @remarks
  *		The UIAlertView creation method lets you keep the dialog localized in case you provide translation
  *		for "OK" string in your Localizable.strings file.
  */
+ (UIAlertView *)alertViewFromError:(NSError *)error;

/**
  * There is often need to just show UIAlertView with a custom message and OK button without providing a delegate
  * or any custom buttons.
  *
  * @remarks
  *		The UIAlertView creation method lets you keep the dialog localized in case you provide translation
  *		for "OK" string in your Localizable.strings file.
  */
+ (void)showWithMessage:(NSString *)message;
+ (void)showWithError:(NSError *)error;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message error:(NSError *)error;

@end
