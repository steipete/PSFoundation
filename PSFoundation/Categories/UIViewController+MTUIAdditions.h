//
//  UIViewController+MTUIAdditions.h
//  PSFoundation
//
//  Created by Matthias Tretter on 01.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMTActivityViewTag      34032

@interface UIViewController (MTUIAdditions)

// shows a big loading indicator centered in the view
- (void)showLoadingIndicator;
// hides the loading indicator and removes it from the view-hierarchy
- (void)hideLoadingIndicator;

@end
