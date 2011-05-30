//
//  UIScrollView+MTAdditions.h
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import <UIKit/UIkit.h>


@interface UIScrollView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Automatic Calculation of ContentSize (height) depending on View-Content
//===========================================================

- (void)autocalculateContentHeight;
- (void)autocalculateContentHeightWithPadding:(CGFloat)padding;

- (void)autocalculateContentWidth;
- (void)autocalculateContentWidthWithPadding:(CGFloat)padding;

@end
