//
//  UITextView+MTUIAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 27.12.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import "UITextView+MTUIAdditions.h"


@implementation UITextView (MTUIAdditions)

- (void) sizeToFitNeededHeight {
	CGRect f = self.frame;
	f.size.height = self.contentSize.height;
	self.frame = f;
}

@end
