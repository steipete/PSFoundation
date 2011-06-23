//
//  ShadowedTableView.m
//  ShadowedTableView
//
//  Created by Matt Gallagher on 2009/08/21.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
// http://cocoawithlove.com/2009/08/adding-shadow-effects-to-uitableview.html
//

#import "ShadowedTableView.h"
#import "PSShadowView.h"

#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)

@implementation ShadowedTableView

@synthesize originShadow = _originShadow, topShadow = _topShadow, bottomShadow = _bottomShadow;

- (void)layoutSubviews {
	[super layoutSubviews];

	// Construct the origin shadow if needed
	if (!_originShadow) {
		self.originShadow = [PSShadowView shadowAsInverse:NO];
		[self.layer insertSublayer:_originShadow atIndex:0];
	} else if (![[self.layer.sublayers objectAtIndex:0] isEqual:_originShadow]) {
		[self.layer insertSublayer:_originShadow atIndex:0];
	}
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	// Stretch and place the origin shadow
	_originShadow.frame = CGRectMake(0, self.contentOffset.y, self.frame.size.width, SHADOW_HEIGHT);
	
	[CATransaction commit];
	
	NSArray *indexPathsForVisibleRows = [self indexPathsForVisibleRows];
	if (!indexPathsForVisibleRows.count) {
		[_topShadow removeFromSuperlayer];
		[_bottomShadow removeFromSuperlayer];
        self.topShadow = nil;
        self.bottomShadow = nil;
		return;
	}
	
	NSIndexPath *firstRow = [indexPathsForVisibleRows objectAtIndex:0];
	if (!firstRow.section == 0 && !firstRow.row) {
		UIView *cell = [self cellForRowAtIndexPath:firstRow];
		if (!_topShadow) {
			self.topShadow = [PSShadowView shadowAsInverse:YES];
			[cell.layer insertSublayer:_topShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:_topShadow]) {
			[cell.layer insertSublayer:_topShadow atIndex:0];
		}
		_topShadow.frame = CGRectMake(0, -SHADOW_INVERSE_HEIGHT, cell.frame.size.width, SHADOW_INVERSE_HEIGHT);
	} else {
		[_topShadow removeFromSuperlayer];
        self.topShadow = nil;
	}

	NSIndexPath *lastRow = [indexPathsForVisibleRows lastObject];
	if (lastRow.section == self.numberOfSections - 1 && lastRow.row == [self numberOfRowsInSection:lastRow.section] - 1) {
		UIView *cell = [self cellForRowAtIndexPath:lastRow];
		if (!_bottomShadow) {
			self.bottomShadow = [PSShadowView shadowAsInverse:NO];
			[cell.layer insertSublayer:_bottomShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:_bottomShadow]) {
			[cell.layer insertSublayer:_bottomShadow atIndex:0];
		}
		_bottomShadow.frame = CGRectMake(0, cell.frame.size.height, cell.frame.size.width, SHADOW_HEIGHT);
	} else {
		[_bottomShadow removeFromSuperlayer];
        self.bottomShadow = nil;
	}
}

- (void)dealloc {
    PS_RELEASE_NIL(_originShadow);
    PS_RELEASE_NIL(_topShadow);
    PS_RELEASE_NIL(_bottomShadow);
    PS_DEALLOC();
}


@end
