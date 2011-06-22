//
//  PSAlertView.h
//  PSFoundation
//
//  Created by Peter Steinberger on 17.03.10.
//  Licensed under MIT. All rights reserved.
//

#import "PSAlertView.h"
#import "UIAlertView+BlocksKit.h"

@implementation PSAlertView

@synthesize alertView = view_;

+ (id)alertWithTitle:(NSString *)title {
    return [self alertWithTitle:title message:nil];
}

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message; {
    return [[[self alloc] initWithTitle:title message:message] autorelease];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    if ((self = [super init])) {
        view_ = [[UIAlertView alloc] initWithTitle:title message:message];
        id instance = self;
        view_.didDismissBlock = ^(NSUInteger selectedIndex) {
            [instance release];
        };
    }
    
    return self;
}

- (void)dealloc {
    view_.delegate = nil;
    MCReleaseNil(view_);
    [super dealloc];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(BKBlock)block {
    assert([title length] > 0 && "cannot set empty button title");
    [view_ setCancelButtonWithTitle:title handler:block];
}

- (void)addButtonWithTitle:(NSString *)title block:(BKBlock)block {
    assert([title length] > 0 && "cannot add button with empty title");
    [view_ addButtonWithTitle:title handler:block];
}

- (void)show {
    [view_ show];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    [view_ dismissWithClickedButtonIndex:buttonIndex animated:animated];
    [view_ alertView:view_ clickedButtonAtIndex:buttonIndex];
}

@end
