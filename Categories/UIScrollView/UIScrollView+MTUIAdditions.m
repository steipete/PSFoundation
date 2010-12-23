//
//  UIScrollView+MTAdditions.m
//  myell0w-helper
//
//  Created by Matthias Tretter on 26.09.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import "UIScrollView+MTUIAdditions.h"

#define DEFAULT_PADDING 20


@implementation UIScrollView (MTUIAdditions)

//===========================================================
#pragma mark -
#pragma mark Automatic Calculation of ContentSize (height) depending on View-Content
//===========================================================


- (void)autocalculateContentSizeWithPadding:(CGFloat)padding
{
	NSArray *sub = [self subviews];
	float max = -1;

	for (id s in sub) {
		if ([s frame].origin.y + [s frame].size.height > max) {
			max = [s frame].origin.y + [s frame].size.height;
		}
	}

	self.contentSize = CGSizeMake(self.frame.size.width, max + padding);
}

- (void)autocalculateContentSize
{
	[self autocalculateContentSizeWithPadding:DEFAULT_PADDING];
}

@end
