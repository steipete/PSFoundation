//
//  UIScrollView+MTAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import "UIScrollView+MTUIAdditions.h"
#import "NSObject+AssociatedObjects.h"

BOOL MTViewIsScrollIndicator(UIView *view);
BOOL MTViewUseForAutocalculation(UIView *view);
CGFloat MTGetMaxPosition(UIScrollView *scrollView, BOOL vertical);

#define kDefaultViewPadding 20

BOOL MTViewIsScrollIndicator(UIView *view);
BOOL MTViewUseForAutocalculation(UIView *view);
CGFloat MTGetMaxPosition(UIScrollView *scrollView, BOOL vertical);


static char excludedKey;

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

BOOL MTViewUseForAutocalculation(UIView *view) {
    return view.alpha > 0.f && view.hidden == NO && !MTViewIsScrollIndicator(view) && !view.excludedFromScrollViewAutocalculation;
}

CGFloat MTGetMaxPosition(UIScrollView *scrollView, BOOL vertical) {
    NSArray *subviews = scrollView.subviews;
	CGFloat max = -1.f;

    // calculate max position of any subview of the scrollView
	for (UIView *view in subviews) {
        if (MTViewUseForAutocalculation(view)) {
            CGFloat maxOfView = vertical ? CGRectGetMaxY(view.frame) : CGRectGetMaxX(view.frame);

            if (maxOfView > max) {
                max = maxOfView;
            }
        }
	}

    return max;
}


@implementation UIView (MTUIScrollAdditions) 

- (BOOL)excludedFromScrollViewAutocalculation {
    NSNumber *excluded = [self associatedValueForKey:&excludedKey];
    
    if (excluded)
        return [excluded boolValue];
    
    return NO;
}

- (void)setExcludedFromScrollViewAutocalculation:(BOOL)excludedFromScrollViewAutocalculation {
    NSNumber *excluded = [NSNumber numberWithBool:excludedFromScrollViewAutocalculation];
    [self associateValue:excluded withKey:&excludedKey];
}

@end


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
