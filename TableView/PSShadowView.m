//
//  PSShadowView.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSShadowView.h"

#define SHADOW_HEIGHT 20.0
#define SHADOW_INVERSE_HEIGHT 10.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)

@interface PSShadowView ()
@property (nonatomic, retain) CAGradientLayer *topShadowLayer;
@property (nonatomic, retain) CAGradientLayer *bottomShadowLayer;
@end


@implementation PSShadowView

@synthesize topShadowLayer = _topShadowLayer;
@synthesize bottomShadowLayer = _bottomShadowLayer;
@synthesize topShadow = _topShadow;
@synthesize bottomShadow = _bottomShadow;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark static

+ (PSShadowView *)viewWithSubview:(UIView *)view {
  PSShadowView *shadowView = [[[[self class] alloc] init] autorelease];
  shadowView.topShadow = YES;
  shadowView.bounds = view.bounds;
  shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [shadowView addSubview:view];
  return shadowView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private

// borrowed from ShadowTableView
- (CAGradientLayer *)shadowAsInverse:(BOOL)inverse {
	CAGradientLayer *newShadow = [[[CAGradientLayer alloc] init] autorelease];
	CGRect newShadowFrame =
  CGRectMake(0, 0, self.frame.size.width,
             inverse ? SHADOW_INVERSE_HEIGHT : SHADOW_HEIGHT);
	newShadow.frame = newShadowFrame;
	CGColorRef darkColor =
  [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:
   inverse ? (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT) * 0.6 : 0.6].CGColor;
	CGColorRef lightColor = [UIColor clearColor].CGColor;
                          //[self.backgroundColor colorWithAlphaComponent:0.0].CGColor;
	newShadow.colors =
  [NSArray arrayWithObjects:
   (id)(inverse ? lightColor : darkColor),
   (id)(inverse ? darkColor : lightColor),
   nil];
	return newShadow;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
  }
  return self;
}

- (void)dealloc {
  MCRelease(_topShadowLayer);
  MCRelease(_bottomShadowLayer);

  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

- (void)setFrame:(CGRect)rect {
  [super setFrame:rect];
  [self setNeedsDisplay];
}

// layoutSubviews
//
// Override to layout the shadows
//
- (void)layoutSubviews {
	[super layoutSubviews];

  if (self.isTopShadow) {
    if (!self.topShadowLayer)
    {
      self.topShadowLayer = [self shadowAsInverse:YES];
      [self.layer addSublayer:self.topShadowLayer];
    }
    else if ([self.layer.sublayers indexOfObjectIdenticalTo:self.topShadowLayer] != 0)
    {
      [self.layer addSublayer:self.topShadowLayer];
    }

    CGRect shadowFrame = self.topShadowLayer.frame;
    shadowFrame.size.width = self.frame.size.width;
    shadowFrame.origin.y = -SHADOW_INVERSE_HEIGHT;
    self.topShadowLayer.frame = shadowFrame;
  }else {
    [self.topShadowLayer removeFromSuperlayer];
    self.topShadowLayer = nil;
  }


  if (self.isBottomShadow) {
    if (!self.bottomShadowLayer)
    {
      self.bottomShadowLayer = [self shadowAsInverse:NO];
      [self.layer insertSublayer:self.bottomShadowLayer atIndex:0];
    }
    else if ([self.layer.sublayers indexOfObjectIdenticalTo:self.bottomShadowLayer] != 0)
    {
      [self.layer insertSublayer:self.bottomShadowLayer atIndex:0];
    }

    CGRect shadowFrame = self.bottomShadowLayer.frame;
    shadowFrame.size.width = self.frame.size.width;
    shadowFrame.origin.y = self.frame.size.height;
    self.bottomShadowLayer.frame = shadowFrame;
  }else {
    [self.bottomShadowLayer removeFromSuperlayer];
    self.bottomShadowLayer = nil;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

- (void)setTopShadow:(BOOL)flag {
  _topShadow = flag;
  [self setNeedsLayout];
}

- (void)setBottomShadow:(BOOL)flag {
  _bottomShadow = flag;
  [self setNeedsLayout];
}

@end
