//
//  PSGenericView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 21.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface PSGenericView : UIView {
  BOOL highlighted_;
  BOOL selected_;
  BOOL displayInOverlay_;
}

@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isDisplayInOverlay) BOOL displayInOverlay;

@end
