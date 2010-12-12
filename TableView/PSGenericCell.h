//
//  PSGenericCell.h
//  PSFoundation
//
//  Created by Peter Steinberger on 21.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@class PSGenericView;

@interface PSGenericCell : UITableViewCell {
  PSGenericView *_cellView;
}

@property (nonatomic, retain) PSGenericView *cellView;
@property (nonatomic, getter=isDisplayInOverlay) BOOL displayInOverlay;

@end
