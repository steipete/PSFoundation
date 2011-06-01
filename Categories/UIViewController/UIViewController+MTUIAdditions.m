//
//  UIViewController+MTUIAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 01.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "UIViewController+MTUIAdditions.h"


@implementation UIViewController (MTUIAdditions)

- (void)showLoadingIndicator {
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    
    activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    activityView.center = self.view.center;
    activityView.tag = kMTActivityViewTag;
    
    [self.view addSubview:activityView];
    [activityView startAnimating];
}

- (void)hideLoadingIndicator {
    id activityView = [self.view viewWithTag:kMTActivityViewTag];
    
    if ([activityView isKindOfClass:[UIActivityIndicatorView class]]) {
        [activityView stopAnimating];
    }
    
    [activityView removeFromSuperview];
}

@end
