//
//  PSActionSheet.m
//  PSFoundation
//
//  Created by Landon Fuller on 7/3/09.
//  Copyright 2009 Plausible Labs. All rights reserved.
//

#import "PSActionSheet.h"
#import "UIActionSheet+BlocksKit.h"

@implementation PSActionSheet
@synthesize sheet = sheet_;

+ (id)sheetWithTitle:(NSString *)title {
    return [[[self alloc] initWithTitle:title] autorelease];
}

- (id)initWithTitle:(NSString *)title {
    if ((self = [super init])) {
        sheet_ = [[UIActionSheet alloc] initWithTitle:title];
        sheet_.didDismissBlock = ^(NSUInteger selectedIndex) {
            [self release];
        };
    }
    return self;
}

- (void) dealloc {
    sheet_.delegate = nil;
    MCReleaseNil(sheet_);
    [super dealloc];
}

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(void (^)())block {
    assert([title length] > 0 && "sheet destructive button title must not be empty");
    [self.sheet setDestructiveButtonWithTitle:title handler:block];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block {
    assert([title length] > 0 && "sheet cancel button title must not be empty");
    [self.sheet setCancelButtonWithTitle:title handler:block];
}

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block {
    assert([title length] > 0 && "cannot add button with empty title");
    [self.sheet addButtonWithTitle:title handler:block];
}

- (void)showInView:(UIView *)view {
  [sheet_ showInView:view];
  [self retain];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
  [sheet_ showFromBarButtonItem:item animated:animated];
  [self retain];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
  [sheet_ showFromRect:rect inView:view animated:animated];
  [self retain];
}

@end
