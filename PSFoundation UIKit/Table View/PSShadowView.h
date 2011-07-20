//
//  PSShadowView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 09.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface PSShadowView : UIView

+ (PSShadowView *)viewWithSubview:(UIView *)view;
+ (CAGradientLayer *)shadowAsInverse:(BOOL)yes;

@property (nonatomic, assign, getter=isTopShadow) BOOL topShadow;
@property (nonatomic, assign, getter=isBottomShadow) BOOL bottomShadow;

@end
