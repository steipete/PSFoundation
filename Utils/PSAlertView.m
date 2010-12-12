//
//  PSAlertView.m
//
//  Created by Peter Steinberger on 17.03.10.
//  Loosely based on Landon Fullers "Using Blocks", Plausible Labs Cooperative.
//  http://landonf.bikemonkey.org/code/iphone/Using_Blocks_1.20090704.html
//

#import "PSAlertView.h"

@implementation PSAlertView

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Static

+ (PSAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message {
  return [[[PSAlertView alloc] initWithTitle:title message:message] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
  if ((self = [super init])) {
    view_ = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:self
                             cancelButtonTitle:nil
                             otherButtonTitles:nil];
    blocks_ = [[NSMutableArray alloc] init];
  }

  return self;
}

- (void)dealloc {
  view_.delegate = nil;
  MCRelease(view_);
  MCRelease(blocks_);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block {
  assert([title length] > 0 && "cannot set empty button title");

  [self addButtonWithTitle:title block:block];
  view_.cancelButtonIndex = (view_.numberOfButtons - 1);
}

- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block {
  assert([title length] > 0 && "cannot add button with empty title");

  if (block) {
    [blocks_ addObject:[[block copy] autorelease]];
  }
  else {
    [blocks_ addObject:[NSNull null]];
  }

  [view_ addButtonWithTitle:title];
}

- (void)show {
  [view_ show];

  /* Ensure that the delegate (that's us) survives until the sheet is dismissed */
  [self retain];
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
  [view_ dismissWithClickedButtonIndex:buttonIndex animated:animated];
  // TODO: does this call the delegate? (it should)
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  /* Run the button's block */
  if (buttonIndex >= 0 && buttonIndex < [blocks_ count]) {
    id obj = [blocks_ objectAtIndex: buttonIndex];
    if (![obj isEqual:[NSNull null]]) {
      ((void (^)())obj)();
    }
  }

  /* AlertView to be dismissed, drop our self reference */
  [self release];
}

@end
