//
//  PSTableViewController.m
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//
//  References:
//   - http://cocoawithlove.com/2009/03/recreating-uitableviewcontroller-to.html
//

#import "PSTableViewController.h"
#import "ShadowedTableView.h"

@interface PSTableViewController ()
- (void)keyboardChanged:(NSNotification *)notification up:(BOOL)up;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
@end

@implementation PSTableViewController

@synthesize tableView, tableViewStyle, useShadows;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)dealloc {
    tableView.delegate = nil;
    tableView.dataSource = nil;
    self.tableView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *newTableView = [self createTableView];
    newTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    newTableView.frame = CGRectClearCoords(self.view.frame);
    [self.view addSubview:newTableView];
    self.tableView = newTableView;
}

- (void)viewDidUnload {
    self.tableView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView flashScrollIndicators];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

    #if TARGET_IPHONE_SIMULATOR && defined(DEBUG)
    PSSimulateMemoryWarning();
    #endif

    [super viewDidAppear:animated];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -
#pragma mark Public

- (id)initWithStyle:(UITableViewStyle)aTableViewStyle {
    if ((self = [super init])) {
        tableViewStyle = aTableViewStyle;
    }
    return self;
}

// can be overridden!
- (UITableView *)createTableView {
    UITableView *newTableView = nil;
    
    if (useShadows)
        newTableView = [[ShadowedTableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    else
        newTableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    
    return [newTableView autorelease];
}

- (void)setTableView:(UITableView *)newTableView {
    if ([tableView isEqual:newTableView])
        return;
    [tableView release];
    tableView = [newTableView retain];
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark -
#pragma mark Private

- (void)keyboardChanged:(NSNotification *)notification up:(BOOL)up {
    // don't move if search display controller is active
    if (self.searchDisplayController.active) {
        return;
    }
    
    // if we are in a popover, don't change the size. popover manages this for us
    // http://stackoverflow.com/questions/4191840/determine-if-a-view-is-inside-of-a-popover-view
    // I *guess* this is appstore-safe, we'll see on the next submission
    UIView *v = self.view;
    for (;v.superview != nil; v=v.superview) {
        if (!strcmp(object_getClassName(v), "UIPopoverView")) {
            return;
        }
    }
    
    NSDictionary* userInfo = [notification userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    // Animate up or down
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.tableView.frame;
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    
    newFrame.size.height -= keyboardFrame.size.height * (up? 1 : -1);
    self.tableView.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [self keyboardChanged:notification up:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self keyboardChanged:notification up:NO];
}


@end
