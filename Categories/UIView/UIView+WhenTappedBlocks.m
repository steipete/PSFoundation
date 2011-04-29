//
//  UIView+WhenTappedBlocks.m
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#if NS_BLOCKS_AVAILABLE

#import "UIView+WhenTappedBlocks.h"

@implementation UIView (WhenTappedBlocks)

- (void) whenTapped:(WhenTappedBlock)block {
	UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];
	gr.delegate = [JMWhenTappedBlockKeeper sharedInstance];
	gr.numberOfTapsRequired = 1;

	self.userInteractionEnabled = YES;

	[self addGestureRecognizer:gr];

	[gr release];

	[[JMWhenTappedBlockKeeper sharedInstance] setBlock:block forWhenViewIsTapped:self];
}
- (void) whenTouchedDown:(WhenTouchedDownBlock)block {
	self.userInteractionEnabled = YES;

	[[JMWhenTappedBlockKeeper sharedInstance] setBlock:block forWhenViewIsTouchedDown:self];
}
- (void) whenTouchedUp:(WhenTouchedUpBlock)block {
	self.userInteractionEnabled = YES;

	[[JMWhenTappedBlockKeeper sharedInstance] setBlock:block forWhenViewIsTouchedUp:self];	
}

- (void) viewWasTapped:(id)sender {
	WhenTappedBlock b = [[JMWhenTappedBlockKeeper sharedInstance] whenTappedBlockForView:self];

	b();
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];

	if([[JMWhenTappedBlockKeeper sharedInstance] whenTouchedDownBlockForView:self]) {
		WhenTouchedDownBlock b = [[JMWhenTappedBlockKeeper sharedInstance] whenTouchedDownBlockForView:self];
		b();
	}
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];	

	
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];

	if([[JMWhenTappedBlockKeeper sharedInstance] whenTouchedUpBlockForView:self]) {
		WhenTouchedUpBlock b = [[JMWhenTappedBlockKeeper sharedInstance] whenTouchedUpBlockForView:self];
		b();
	}
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];

	
}

@end

#endif