//
//  UIViewController+MTUIAdditions.h
//  PSFoundation
//
//  Created by Matthias Tretter on 01.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#define kMTActivityViewTag      34032

@interface UIViewController (MTUIAdditions)

// shows a big loading indicator centered in the view
- (void)showLoadingIndicator;
// hides the loading indicator and removes it from the view-hierarchy
- (void)hideLoadingIndicator;
// shows the loading indicator instead of another view, same position, same autoresizing
- (void)showLoadingIndicatorInsteadOfView:(UIView *)view;

// shows a loading indicator as the rightBarButtonItem
- (void)showLoadingIndicatorInNavigationBar;
// hides the right bar button item indicator
- (void)hideLoadingIndicatorInNavigationBar;

// shows the loading indicator in the accessory view of the cell
- (void)showLoadingIndicatorInTableViewCell:(UITableViewCell *)cell;
- (void)hideLoadingIndicatorInTableViewCell;

@end
