//
//  UIAlertView+SCMethods.m
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/14/10.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

#import "UIAlertView+SCMethods.h"

@implementation UIAlertView (SCMethods)

+ (UIAlertView *)alertViewFromError:(NSError *)error {
    return [[[UIAlertView alloc] initWithTitle:[error localizedFailureReason]
                                       message:[error localizedDescription]
                                      delegate:nil
                             cancelButtonTitle:_(@"OK")
                             otherButtonTitles:nil] autorelease];
}

+ (void)showWithError:(NSError *)error {
    return [self showWithTitle:_(@"Error") message:[error localizedDescription]];
}

+ (void)showWithMessage:(NSString *)message {
    return [self showWithTitle:nil message:message];
}

+ (void)showWithTitle:(NSString *)title {
    return [self showWithTitle:title message:nil];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:_(@"OK")
                                         otherButtonTitles:nil];
    [[view autorelease] show];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message error:(NSError *)error {
    NSString *messageWithError = message;
    if (error)
        messageWithError = [NSString stringWithFormat:@"%@\n(%@)", message, [error localizedDescription]];
    return [self showWithTitle:title message:messageWithError];
}

@end
