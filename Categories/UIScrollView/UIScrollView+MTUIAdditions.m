//
//  UIScrollView+MTAdditions.m
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import "UIScrollView+MTUIAdditions.h"

#define kDefaultViewPadding 20

BOOL MTViewIsScrollIndicator(UIView *view) {
    // TODO: Is there a better way to detect the scrollIndicators?
    // This can break ...

    if ([view isKindOfClass:[UIImageView class]]) {
        if (CGRectGetHeight(view.frame) == 7.f || CGRectGetWidth(view.frame) == 7.f) {
            if ([view.layer animationForKey:@"position"] != nil) {
                return YES;
            }
        }
    }

    return NO;
}

CGFloat MTGetMaxPosition(UIScrollView *scrollView, BOOL vertical) {
    NSArray *subviews = scrollView.subviews;
	CGFloat max = -1.f;

    // calculate max position of any subview of the scrollView
	for (UIView *view in subviews) {
        if (view.alpha > 0.f && view.hidden == NO && !MTViewIsScrollIndicator(view)) {
            CGFloat maxOfView = vertical ? CGRectGetMaxY(view.frame) : CGRectGetMaxX(view.frame);

            if (maxOfView > max) {
                max = maxOfView;
            }
        }
	}

    return max;
}


@implementation UIScrollView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Automatic Calculation of ContentSize (height) depending on View-Content
//===========================================================

- (void)autocalculateContentHeight {
	[self autocalculateContentHeightWithPadding:kDefaultViewPadding];
}

- (void)autocalculateContentHeightWithPadding:(CGFloat)padding {
	CGFloat maxHeight = MTGetMaxPosition(self, YES);

    self.contentSize = CGSizeMake(self.bounds.size.width, maxHeight + padding);
}

- (void)autocalculateContentWidth {
    [self autocalculateContentWidthWithPadding:kDefaultViewPadding];
}

- (void)autocalculateContentWidthWithPadding:(CGFloat)padding {
    CGFloat maxWidth = MTGetMaxPosition(self, NO);

    self.contentSize = CGSizeMake(maxWidth + padding, self.bounds.size.height);
}

@end
