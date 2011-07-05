//
//  UIViewController+MTUIAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 01.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "UIViewController+MTUIAdditions.h"
#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>


#define kMTActivityFadeDuration  0.3

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Keys for associated objects
////////////////////////////////////////////////////////////////////////

static char oldBarButtonItemKey;


@implementation UIViewController (MTUIAdditions)

- (void)showLoadingIndicator {
    id oldActivityView = [self.view viewWithTag:kMTActivityViewTag];
    UIActivityIndicatorView *activityView = nil;
    
    if (oldActivityView == nil) { 
        activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        
        activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        CGRect activityFrame = activityView.frame;
        CGFloat originX = (self.view.bounds.size.width - activityFrame.size.width) / 2; 
        CGFloat originY = (self.view.bounds.size.height - activityFrame.size.height) / 2; 
        
        activityFrame.origin.x = floorl(originX);
        activityFrame.origin.y = floorl(originY);
        
        activityView.frame = activityFrame;
        activityView.tag = kMTActivityViewTag;
        
        [self.view addSubview:activityView];
    } 
    // there is already a loading indicator showing
    else {
        if ([oldActivityView isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)oldActivityView;
        }
    }
    
    activityView.hidden = NO;
    activityView.alpha = 0.0f;
    [self.view bringSubviewToFront:activityView];
    [activityView startAnimating];
    
    [UIView animateWithDuration:kMTActivityFadeDuration animations:^(void) {
        activityView.alpha = 1.0f;
    }];
}

- (void)hideLoadingIndicator {
    id activityView = [self.view viewWithTag:kMTActivityViewTag];
    
    if ([activityView isKindOfClass:[UIActivityIndicatorView class]]) {
        [activityView stopAnimating];
    }
    
    [UIView animateWithDuration:kMTActivityFadeDuration animations:^(void) {
        [activityView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [activityView removeFromSuperview];
    }];
}


- (void)showLoadingIndicatorInNavigationBar {
    // initing the loading view
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 24.f, 26.f)];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.f, 2.f, 20.f, 20.f)];
    
    [backgroundView addSubview:activityView];
    [activityView startAnimating];
    
    if (self.navigationItem.rightBarButtonItem)
        [self associateValue:self.navigationItem.rightBarButtonItem withKey:&oldBarButtonItemKey];
    
    self.navigationItem.rightBarButtonItem = PS_AUTORELEASE([[UIBarButtonItem alloc] initWithCustomView:backgroundView]);
    
    #if !PS_HAS_ARC
    [activityView release];
    [backgroundView release];
    #endif
}

- (void)hideLoadingIndicatorInNavigationBar {
    UIBarButtonItem *oldItem = [self associatedValueForKey:&oldBarButtonItemKey];
    self.navigationItem.rightBarButtonItem = oldItem;
}

@end
