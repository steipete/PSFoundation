//
//  UIActionSheet+SCMethods.m
//  PSFoundation
//
//  Created by Aleks Nesterow on 3/25/10.
//  Licensed under MIT.  Copyright 2010 Screen Customs s.r.o.
//

#import "UIActionSheet+SCMethods.h"

@interface UIActionSheet (SCMethodsPrivate)
+ (UIActionSheet *)_actionSheetWithMessage:(NSString *)message;
@end

@implementation UIActionSheet (SCMethods)

+ (void)showWithMessage:(NSString *)message fromTabBar:(UITabBar *)tabbar {
	[[UIActionSheet _actionSheetWithMessage:message] showFromTabBar:tabbar];
}


+ (void)showWithMessage:(NSString *)message fromToolbar:(UIToolbar *)toolbar {
	[[UIActionSheet _actionSheetWithMessage:message] showFromToolbar:toolbar];
}


+ (void)showWithMessage:(NSString *)message inView:(UIView *)view {
	[[UIActionSheet _actionSheetWithMessage:message] showInView:view];
}


+ (UIActionSheet *)_actionSheetWithMessage:(NSString *)message {	
	return [[[UIActionSheet alloc] initWithTitle:message
										delegate:nil
							   cancelButtonTitle:NSLocalizedString(@"OK", @"")
						  destructiveButtonTitle:nil
							   otherButtonTitles:nil] autorelease];
}

@end
