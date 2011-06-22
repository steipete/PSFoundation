//
//  ButtonGradientView.h
//  Custom Alert View
//
//  Created by jeff on 5/17/10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum PSGradientButtonStyle {
    GradientButtonCustomStyle,
    GradientButtonAlertStyle,
    GradientButtonDestructiveStyle,
    GradientButtonWhiteStyle,
    GradientButtonBlackStyle,
    GradientButtonWhiteActionStyle,
    GradientButtonBlackActionStyle,
    GradientButtonOrangeStyle,
    GradientButtonConfirmStyle
} PSGradientButtonStyle;

@interface GradientButton : UIButton {
@private
    CGGradientRef   normalGradient;
    CGGradientRef   highlightGradient;
}

// These two arrays define the gradient that will be used
// when the button is in UIControlStateNormal
@property (nonatomic, retain) NSArray *normalGradientColors;     // colors
@property (nonatomic, retain) NSArray *normalGradientLocations;  // relative locations

// These two arrays define the gradient that will be used
// when the button is in UIControlStateHighlighted
@property (nonatomic, retain) NSArray *highlightGradientColors;     // colors
@property (nonatomic, retain) NSArray *highlightGradientLocations;  // relative locations

// This defines the corner radius of the button
@property (nonatomic) CGFloat cornerRadius;

// This defines the size and color of the stroke
@property (nonatomic) CGFloat strokeWeight;
@property (nonatomic, retain) UIColor *strokeColor;


@property (nonatomic, assign) PSGradientButtonStyle style;

- (void)useAlertStyle DEPRECATED_ATTRIBUTE;
- (void)useRedDeleteStyle DEPRECATED_ATTRIBUTE;
- (void)useWhiteStyle DEPRECATED_ATTRIBUTE;
- (void)useBlackStyle DEPRECATED_ATTRIBUTE;
- (void)useWhiteActionSheetStyle DEPRECATED_ATTRIBUTE;
- (void)useBlackActionSheetStyle DEPRECATED_ATTRIBUTE;
- (void)useSimpleOrangeStyle DEPRECATED_ATTRIBUTE;
- (void)useGreenConfirmStyle DEPRECATED_ATTRIBUTE;

@end
