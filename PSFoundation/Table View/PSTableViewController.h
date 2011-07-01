//
//  PSTableViewController.h
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface PSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  NSIndexPath *lastSelectedIndexPath_;

@private
  BOOL useShadows;
  UITableView *tableView;
  UITableViewStyle _tableViewStyle;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, readonly) UITableViewStyle tableViewStyle;

@property (nonatomic) BOOL useShadows;
@property (nonatomic, retain) NSIndexPath *lastSelectedIndexPath;

- (UITableView *)createTableView;

- (id)initWithStyle:(UITableViewStyle)style;

@end
