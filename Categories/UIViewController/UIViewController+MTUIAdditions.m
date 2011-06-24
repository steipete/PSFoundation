//
//  UIViewController+MTUIAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 01.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "UIViewController+MTUIAdditions.h"
#import <objc/runtime.h>


#define kMTActivityFadeDuration  0.3
#define kMTMaxActivityFrameWidth 37

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Keys for associated objects
////////////////////////////////////////////////////////////////////////

static char oldBarButtonItemKey;
static char cellKey;


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

- (void)showLoadingIndicatorInsteadOfView:(UIView *)view {
    id oldActivityView = [self.view viewWithTag:kMTActivityViewTag];
    UIActivityIndicatorView *activityView = nil;
    CGRect activityFrame = view.frame;
    
    // make activityView a circle (same width+height, only use integral coordinates to prohibit blurry activityView)
    if (activityFrame.size.width < activityFrame.size.height) {
        activityFrame = CGRectIntegral(CGRectInset(activityFrame, 0, (activityFrame.size.height - activityFrame.size.width)/2));
    } else {
        activityFrame = CGRectIntegral(CGRectInset(activityFrame, (activityFrame.size.width - activityFrame.size.height)/2, 0));
    }
    
    // limit size of activityView
    if (activityFrame.size.width > kMTMaxActivityFrameWidth) {
        activityFrame = CGRectIntegral(CGRectInset(activityFrame, (activityFrame.size.width-kMTMaxActivityFrameWidth)/2,(activityFrame.size.height - kMTMaxActivityFrameWidth)/2));
    }
    
    if (oldActivityView == nil) { 
        activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        
        activityView.tag = kMTActivityViewTag;
    } 
    // there is already a loading indicator showing
    else {
        if ([oldActivityView isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)oldActivityView;
        }
    }
    
    activityView.frame = activityFrame;
    [view.superview addSubview:activityView];
    activityView.autoresizingMask = view.autoresizingMask;
    
    view.alpha = 0.f;
    activityView.hidden = NO;
    activityView.alpha = 0.0f;
    [activityView startAnimating];
    
    [UIView animateWithDuration:kMTActivityFadeDuration animations:^(void) {
        activityView.alpha = 1.0f;
    }];
}

- (void)hideLoadingIndicator {
    id activityView = [self.view viewWithTag:kMTActivityViewTag];
    
    [UIView animateWithDuration:kMTActivityFadeDuration animations:^(void) {
        [activityView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        if ([activityView isKindOfClass:[UIActivityIndicatorView class]]) {
            [activityView stopAnimating];
        }
        
        [activityView removeFromSuperview];
    }];
}


- (void)showLoadingIndicatorInNavigationBar {
    // initing the loading view
    UIView *backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 24.f, 26.f)] autorelease];
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.f, 2.f, 20.f, 20.f)] autorelease];
    
    [backgroundView addSubview:activityView];
    [activityView startAnimating];
    
    if (self.navigationItem.rightBarButtonItem != nil && ![self.navigationItem.rightBarButtonItem isKindOfClass:[UIActivityIndicatorView class]]) {
        objc_setAssociatedObject(self, &oldBarButtonItemKey, self.navigationItem.rightBarButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backgroundView] autorelease];
}

- (void)hideLoadingIndicatorInNavigationBar {
    UIBarButtonItem *oldItem = (UIBarButtonItem *)objc_getAssociatedObject(self, &oldBarButtonItemKey);
    self.navigationItem.rightBarButtonItem = oldItem;
}

- (void)showLoadingIndicatorInTableViewCell:(UITableViewCell *)cell {
    UIActivityIndicatorView *activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
    [activityIndicator startAnimating];
    cell.accessoryView = activityIndicator;
    
    objc_setAssociatedObject(self, &cellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hideLoadingIndicatorInTableViewCell {
    UITableViewCell *cell = (UITableViewCell *)objc_getAssociatedObject(self, &cellKey);
    
    cell.accessoryView = nil;
}

@end
