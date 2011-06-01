//
//  SCFooterLabel.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 3/12/10.
//	aleks.nesterow@gmail.com
//
//  Copyright © 2010 Screen Customs s.r.o.
//	All rights reserved.
//

#import "SCFooterLabel.h"

/* Basically if 500 px height is not enough, you should probably revise your textings. */
#define kMaxLabelHeight		500
/* Again, if 100 lines is fairly enough for a UITableView section footer if you're designing the app correctly. */
#define kLabelNumberOfLines	100
#define kVerticalMargin		10
#define kFontSize			15

@interface SCFooterLabel (/* Private methods */)

- (void)__initializeComponent;

@end

@implementation SCFooterLabel

- (id)init {

	if ((self = [super init])) {
		[self __initializeComponent];
	}

	return self;
}

- (id)initWithFrame:(CGRect)frame {

	if ((self = [super initWithFrame:frame])) {

		[self __initializeComponent];
	}

	return self;
}

- (id)initWithText:(NSString *)footerText {

	if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 100)])) {

		[self __initializeComponent];

		self.text = footerText;
	}

	return self;
}

- (void)__initializeComponent {

	self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.backgroundColor = [UIColor clearColor];
	self.font = [UIFont systemFontOfSize:kFontSize];
	self.minimumFontSize = kFontSize;
	self.numberOfLines = kLabelNumberOfLines;
	self.shadowColor = [UIColor whiteColor];
	self.shadowOffset = CGSizeMake(0, 1);
	self.textAlignment = UITextAlignmentCenter;
	self.textColor = RGBCOLOR(77, 87, 107);
}

- (void)dealloc {

    [super dealloc];
}

- (CGFloat)heightForCurrentText {

	CGFloat width = CGRectGetWidth(self.frame);

	CGFloat result;

	NSString *text = self.text;

	if (text.empty) {

		result = 0;

	} else {

		result = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(width, kMaxLabelHeight)
					  lineBreakMode:self.lineBreakMode].height;
		result += kVerticalMargin;
	}

	return result;
}

@end
