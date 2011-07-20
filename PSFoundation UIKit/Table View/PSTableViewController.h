//
//  PSTableViewController.h
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface PSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, readonly) UITableViewStyle tableViewStyle;
@property (nonatomic) BOOL useShadows;

- (id)initWithStyle:(UITableViewStyle)style;
- (UITableView *)createTableView;

@end
