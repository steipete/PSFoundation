//
//  UIViewControllerHelper.h
//  Enormego Cocoa Helpers
//
//  Created by Shaun Harrison on 3/18/09.
//  Copyright (c) 2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@protocol PopUpViewControllerDelegate<NSObject>
@required
@property(nonatomic,retain) UIViewController* poppedUpFromViewController;
@end


@interface UIViewController (Helper)

@property (nonatomic, readonly, getter = isViewVisible) BOOL viewVisible;

// A "Pop Up" is intended to only take up a portion of the screen, similar to a UIAlertView

// Adds a "Pop Up" view to the current view controller
- (void)presentPopUpViewController:(UIViewController<PopUpViewControllerDelegate>*)viewController;

// Dismisses the "Pop Up" view
- (void)dismissPopUpViewController; // Calls the method below on poppedUpFromViewController
- (void)dismissPopUpViewController:(UIViewController<PopUpViewControllerDelegate>*)viewController;

/**
 Returns the currently visible viewController. If the viewController this method gets called on is
 a UITabBarController it returns the currently selected viewController, if the viewController is a
 UINavigationController is returns the topmost viewController in the navigation-stack. If the viewController
 is no Container-ViewController, it just returns self.
 
 @return the currently visible viewcontroller
 */
- (id)currentVisibleViewController;

@end
#endif