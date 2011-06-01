//
//  UIActionSheet+SCMethods.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/25/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "UIActionSheet+SCMethods.h"

@interface UIActionSheet (SCMethodsPrivate)

+ (UIActionSheet *)actionSheetWithMessage:(NSString *)message;

@end

@implementation UIActionSheet (SCMethodsPrivate)

+ (UIActionSheet *)actionSheetWithMessage:(NSString *)message {
	
	return [[[UIActionSheet alloc] initWithTitle:message
										delegate:nil
							   cancelButtonTitle:NSLocalizedString(@"OK", @"")
						  destructiveButtonTitle:nil
							   otherButtonTitles:nil] autorelease];
}

@end

@implementation UIActionSheet (SCMethods)

+ (void)showWithMessage:(NSString *)message fromTabBar:(UITabBar *)tabbar {
	
	[[UIActionSheet actionSheetWithMessage:message] showFromTabBar:tabbar];
}

+ (void)showWithMessage:(NSString *)message fromToolbar:(UIToolbar *)toolbar {

	[[UIActionSheet actionSheetWithMessage:message] showFromToolbar:toolbar];
}

+ (void)showWithMessage:(NSString *)message inView:(UIView *)view {

	[[UIActionSheet actionSheetWithMessage:message] showInView:view];
}

@end
