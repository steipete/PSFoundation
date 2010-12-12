//
//  DSActivityView.h
//  Dejal Open Source
//
//  Created by David Sinclair on 2009-07-26.
//  Copyright 2009-2010 Dejal Systems, LLC. All rights reserved.
//
//  Redistribution and use in binary and source forms, with or without modification,
//  are permitted for any project, commercial or otherwise, provided that the
//  following conditions are met:
//
//  Redistributions in binary form must display the copyright notice in the About
//  view, website, and/or documentation.
//
//  Redistributions of source code must retain the copyright notice, this list of
//  conditions, and the following disclaimer.
//
//  THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THIS SOFTWARE.
//

#import <UIKit/UIKit.h>


@interface DSActivityView : UIView
{
    UIView *_originalView;
    UIView *_borderView;
    UIActivityIndicatorView *_activityIndicator;
    UILabel *_activityLabel;
    NSUInteger _labelWidth;
    BOOL _showNetworkActivityIndicator;
}

// The view to contain the activity indicator and label.  The bezel style has a semi-transparent rounded rectangle, others are fully transparent:
@property (nonatomic, readonly) UIView *borderView;

// The activity indicator view; automatically created on first access:
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;

// The activity label; automatically created on first access:
@property (nonatomic, readonly) UILabel *activityLabel;

// A fixed width for the label text, or zero to automatically calculate the text size (normally set on creation of the view object):
@property (nonatomic) NSUInteger labelWidth;

// Whether to show the network activity indicator in the status bar.  Set to YES if the activity is network-related.  This can be toggled on and off as desired while the activity view is visible (e.g. have it on while fetching data, then disable it while parsing it).  By default it is not shown:
@property (nonatomic) BOOL showNetworkActivityIndicator;

//  Returns the currently displayed activity view, or nil if there isn't one:
+ (DSActivityView *)currentActivityView;

// Creates and adds an activity view centered within the specified view, using the label "Loading...".  Returns the activity view, already added as a subview of the specified view:
+ (DSActivityView *)newActivityViewForView:(UIView *)addToView;

// Creates and adds an activity view centered within the specified view, using the specified label.  Returns the activity view, already added as a subview of the specified view:
+ (DSActivityView *)newActivityViewForView:(UIView *)addToView withLabel:(NSString *)labelText;

// Creates and adds an activity view centered within the specified view, using the specified label and a fixed label width.  The fixed width is useful if you want to change the label text while the view is visible.  Returns the activity view, already added as a subview of the specified view:
+ (DSActivityView *)newActivityViewForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)labelWidth;

// Designated initializer.  Configures the activity view using the specified label text and width, and adds as a subview of the specified view:
- (DSActivityView *)initForView:(UIView *)addToView withLabel:(NSString *)labelText width:(NSUInteger)labelWidth;

// Immediately removes and releases the view without any animation:
+ (void)removeView;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


// These methods are exposed for subclasses to override to customize the appearance and behavior; see the implementation for details:

@interface DSActivityView ()

@property (nonatomic, retain) UIView *originalView;

- (UIView *)viewForView:(UIView *)view;
- (CGRect)enclosingFrame;
- (void)setupBackground;
- (void)animateShow;
- (void)animateRemove;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface DSWhiteActivityView : DSActivityView
{
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface DSBezelActivityView : DSActivityView
{
}

// Animates the view out from the superview and releases it, or simply removes and releases it immediately if not animating:
+ (void)removeViewAnimated:(BOOL)animated;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface DSKeyboardActivityView : DSBezelActivityView
{
}

// Creates and adds a keyboard-style activity view, using the label "Loading...".  Returns the activity view, already covering the keyboard, or nil if the keyboard isn't currently displayed:
+ (DSKeyboardActivityView *)newActivityView;

// Creates and adds a keyboard-style activity view, using the specified label.  Returns the activity view, already covering the keyboard, or nil if the keyboard isn't currently displayed:
+ (DSKeyboardActivityView *)newActivityViewWithLabel:(NSString *)labelText;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface UIApplication (KeyboardView)

- (UIView *)keyboardView;

@end;
