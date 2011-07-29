//
//  PSShadowedTableView.m
//  PSFoundation
//

#import "PSShadowedTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "PSShadowView.h"

#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)

@interface PSShadowedTableView ()
@property (nonatomic, retain) CAGradientLayer *originShadow;
@property (nonatomic, retain) CAGradientLayer *topShadow;
@property (nonatomic, retain) CAGradientLayer *bottomShadow;
@end

@implementation PSShadowedTableView

@synthesize originShadow, topShadow, bottomShadow;

- (void)layoutSubviews {
	[super layoutSubviews];

	// Construct the origin shadow if needed
	if (!originShadow) {
		self.originShadow = [PSShadowView shadowAsInverse:NO];
		[self.layer insertSublayer:originShadow atIndex:0];
	} else if (![[self.layer.sublayers objectAtIndex:0] isEqual:originShadow]) {
		[self.layer insertSublayer:originShadow atIndex:0];
	}
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];

	// Stretch and place the origin shadow
	originShadow.frame = CGRectMake(0, self.contentOffset.y, self.frame.size.width, SHADOW_HEIGHT);
	
	[CATransaction commit];
	
	NSArray *indexPathsForVisibleRows = [self indexPathsForVisibleRows];
	if (!indexPathsForVisibleRows.count) {
		[topShadow removeFromSuperlayer];
		[bottomShadow removeFromSuperlayer];
        self.topShadow = nil;
        self.bottomShadow = nil;
		return;
	}
	
	NSIndexPath *firstRow = [indexPathsForVisibleRows objectAtIndex:0];
	if (!firstRow.section == 0 && !firstRow.row) {
		UIView *cell = [self cellForRowAtIndexPath:firstRow];
		if (!topShadow) {
			self.topShadow = [PSShadowView shadowAsInverse:YES];
			[cell.layer insertSublayer:topShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:topShadow]) {
			[cell.layer insertSublayer:topShadow atIndex:0];
		}
		topShadow.frame = CGRectMake(0, -SHADOW_INVERSE_HEIGHT, cell.frame.size.width, SHADOW_INVERSE_HEIGHT);
	} else {
		[topShadow removeFromSuperlayer];
        self.topShadow = nil;
	}

	NSIndexPath *lastRow = [indexPathsForVisibleRows lastObject];
	if (lastRow.section == self.numberOfSections - 1 && lastRow.row == [self numberOfRowsInSection:lastRow.section] - 1) {
		UIView *cell = [self cellForRowAtIndexPath:lastRow];
		if (!bottomShadow) {
			self.bottomShadow = [PSShadowView shadowAsInverse:NO];
			[cell.layer insertSublayer:bottomShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:bottomShadow]) {
			[cell.layer insertSublayer:bottomShadow atIndex:0];
		}
		bottomShadow.frame = CGRectMake(0, cell.frame.size.height, cell.frame.size.width, SHADOW_HEIGHT);
	} else {
		[bottomShadow removeFromSuperlayer];
        self.bottomShadow = nil;
	}
}

- (void)dealloc {
    self.originShadow = nil;
    self.topShadow = nil;
    self.bottomShadow = nil;
    [super dealloc];
}


@end
