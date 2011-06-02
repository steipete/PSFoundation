//
//  UIAlertView+SCMethods.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/14/10.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

@interface UIAlertView (SCMethods)

+ (UIAlertView *)alertViewFromError:(NSError *)error;
+ (void)showWithMessage:(NSString *)message;
+ (void)showWithError:(NSError *)error;
+ (void)showWithTitle:(NSString *)title;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message error:(NSError *)error;

@end
