//
//  PSGenericView.m
//  PSFoundation
//
//  Created by Peter Steinberger on 21.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSGenericView.h"


@implementation PSGenericView

@synthesize highlighted = highlighted_;
@synthesize selected = selected_;
@synthesize displayInOverlay = displayInOverlay_;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

- (void)layoutSubviews {
  [self setNeedsDisplay]; // view needs a redraw on portrait/landscape change!
  [super layoutSubviews];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

- (void)setHighlighted:(BOOL)newHighlighted {
  if (highlighted_ != newHighlighted) {
    highlighted_ = newHighlighted;
    [self setNeedsDisplay];
  }
}

- (void)setSelected:(BOOL)newSelected {
  if (selected_ != newSelected) {
    selected_ = newSelected;
    [self setNeedsDisplay];
  }
}


@end
