//
//  PSShadowView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 09.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

// used for views with shadow
// also provides support for custom draw
@interface PSShadowView : UIView {
	CAGradientLayer *_topShadowLayer;
	CAGradientLayer *_bottomShadowLayer;

  BOOL _topShadow;
  BOOL _bottomShadow;

}

+ (PSShadowView *)viewWithSubview:(UIView *)view;
+ (CAGradientLayer *)shadowAsInverse:(BOOL)yes;

@property (nonatomic, assign, getter=isTopShadow) BOOL topShadow;
@property (nonatomic, assign, getter=isBottomShadow) BOOL bottomShadow;

@end
