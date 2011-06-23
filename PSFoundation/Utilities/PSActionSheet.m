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
    PS_RETURN_AUTORELEASED([[self alloc] initWithTitle:title]);
}

- (id)initWithTitle:(NSString *)title {
    if ((self = [super init])) {
        sheet_ = [[UIActionSheet alloc] initWithTitle:title];
        
        #if !PS_HAS_ARC
        id instance = self;
        sheet_.didDismissBlock = ^(NSUInteger selectedIndex) {
            [instance release];
        };
        #endif
    }
    return self;
}

- (void)dealloc{
    PS_RELEASE_NIL(sheet_);
    PS_DEALLOC();
}

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(BKBlock)block {
    assert([title length] > 0 && "sheet destructive button title must not be empty");
    [self.sheet setDestructiveButtonWithTitle:title handler:block];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(BKBlock)block {
    assert([title length] > 0 && "sheet cancel button title must not be empty");
    [self.sheet setCancelButtonWithTitle:title handler:block];
}

- (void)addButtonWithTitle:(NSString *)title block:(BKBlock)block {
    assert([title length] > 0 && "cannot add button with empty title");
    [self.sheet addButtonWithTitle:title handler:block];
}

- (void)showInView:(UIView *)view {
    [sheet_ showInView:view];
    PS_DO_RETAIN(self);
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
    [sheet_ showFromBarButtonItem:item animated:animated];
    PS_DO_RETAIN(self);
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    [sheet_ showFromRect:rect inView:view animated:animated];
    PS_DO_RETAIN(self);
}

@end
