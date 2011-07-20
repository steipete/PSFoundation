//
//  UIScrollView+MTAdditions.h
//  PSFoundation
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

@interface UIView (MTUIScrollAdditions)

@property (nonatomic, assign) BOOL excludedFromScrollViewAutocalculation;

@end


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
