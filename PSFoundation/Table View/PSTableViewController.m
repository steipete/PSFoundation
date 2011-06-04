//
//  PSTableViewController.m
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "PSTableViewController.h"
#import "ShadowedTableView.h"

@interface PSTableViewController ()
@end

// http://cocoawithlove.com/2009/03/recreating-uitableviewcontroller-to.html
@implementation PSTableViewController

@synthesize tableViewStyle = _tableViewStyle;
@synthesize useShadows;
@synthesize lastSelectedIndexPath = lastSelectedIndexPath_;

///////////////////////////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)init {
    if((self = [self initWithStyle:UITableViewStylePlain])) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)tableViewStyle {
    if ((self = [super init])) {
        _tableViewStyle = tableViewStyle;
    }
    return self;
}

- (void)dealloc {
    [tableView setDelegate:nil];
    [tableView setDataSource:nil];
    MCRelease(tableView);
    MCRelease(lastSelectedIndexPath_);

    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

/*
 - (void)loadView {
 [super loadView];

 if (self.nibName) {
 NSAssert(tableView != nil, @"NIB file did not set tableView property.");
 return;
 }

 self.view = newTableView;
 self.tableView = newTableView;
 }*/

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *newTableView = [self createTableView];
    newTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    newTableView.frame = CGRectClearCoords(self.view.frame);
    [self.view addSubview:newTableView];
    self.tableView = newTableView;
}

- (void)viewDidUnload {
    MCReleaseNil(tableView);
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.tableView flashScrollIndicators];
    // you have to set self.lastSelectedIndexPath in
    // - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    [self.tableView deselectRowAtIndexPath:self.lastSelectedIndexPath animated:YES];

#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    // If we are running in the simulator and it's the DEBUG target
    // then simulate a memory warning. Note that the DEBUG flag isn't
    // defined by default. To define it add this Preprocessor Macro for
    // the Debug target: DEBUG=1
    PSSimulateMemoryWarning();
#endif
#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

// can be overridden!
- (UITableView *)createTableView {
    UITableView *newTableView;

    if (useShadows) {
        newTableView = [[[ShadowedTableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle] autorelease];
    }else {
        newTableView = [[[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle] autorelease];
    }

    return newTableView;
}

- (UITableView *)tableView {
    return tableView;
}

- (void)setTableView:(UITableView *)newTableView {
    if ([tableView isEqual:newTableView])
    {
        return;
    }
    [tableView release];
    tableView = [newTableView retain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
