//
//  ShadowedTableView.h
//  ShadowedTableView
//
//  Created by Matt Gallagher on 2009/08/21.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ShadowedTableView : UITableView

@property (nonatomic, retain) CAGradientLayer *originShadow;
@property (nonatomic, retain) CAGradientLayer *topShadow;
@property (nonatomic, retain) CAGradientLayer *bottomShadow;

@end
