//
//  LRPopoverManager.m
//  PSFoundation
//
//  Created by Luke Redpath on 24/05/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//

#import "LRPopoverManager.h"

NSString *const LRUIPopoverControllerDidDismissNotification = @"LRUIPopoverControllerDidDismissNotification";

@implementation LRPopoverManager

@synthesize currentPopoverController, permitCurrentPopoverControllerToDismiss;

SYNTHESIZE_SINGLETON_FOR_CLASS(LRPopoverManager)

+ (void)initialize {
    if (self == [LRPopoverManager class]) {
        [[LRPopoverManager sharedManager] setPermitCurrentPopoverControllerToDismiss:YES];
    }
}

+ (LRPopoverManager *)sharedManager {
    return [LRPopoverManager sharedInstance];
}

- (void)setCurrentPopoverController:(UIPopoverController *)pc {
    [self dismissCurrentPopoverController:YES];
  
    if (pc != currentPopoverController) {
        PS_SET_RETAINED(currentPopoverController, pc);
        currentPopoverController.delegate = self;
    }
    
    self.permitCurrentPopoverControllerToDismiss = YES;
}

- (void)presentPopoverController:(UIPopoverController *)pc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  self.currentPopoverController = pc;
  [self.currentPopoverController presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

- (void)presentPopoverController:(UIPopoverController *)pc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  self.currentPopoverController = pc;
  [self.currentPopoverController presentPopoverFromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
}

- (void)dismissCurrentPopoverController:(BOOL)animated {
  [self.currentPopoverController dismissPopoverAnimated:animated];
}

- (void)presentControllerInPopoverController:(UIViewController *)vc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  UIPopoverController *pc = PS_AUTORELEASE([[UIPopoverController alloc] initWithContentViewController:vc]);
  [self presentPopoverController:pc fromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

- (void)presentControllerInPopoverController:(UIViewController *)vc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  UIPopoverController *pc = PS_AUTORELEASE([[UIPopoverController alloc] initWithContentViewController:vc]);
  [self presentPopoverController:pc fromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
}

- (void)presentControllerWithNavigationInPopoverController:(UIViewController *)vc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  UINavigationController *navigationController = PS_AUTORELEASE([[UINavigationController alloc] initWithRootViewController:vc]);
  [self presentControllerInPopoverController:navigationController fromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

- (void)presentControllerWithNavigationInPopoverController:(UIViewController *)vc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
  UINavigationController *navigationController = PS_AUTORELEASE([[UINavigationController alloc] initWithRootViewController:vc]);
  [self presentControllerInPopoverController:navigationController fromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  [[NSNotificationCenter defaultCenter] postNotificationName:LRUIPopoverControllerDidDismissNotification object:popoverController];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
  return self.permitCurrentPopoverControllerToDismiss;
}

@end
