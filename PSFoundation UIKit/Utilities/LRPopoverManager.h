//
//  LRPopoverManager.h
//  PSFoundation
//
//  Created by Luke Redpath on 24/05/2010.
//  Copyright 2010 LJR Software Limited. All rights reserved.
//
//  http://github.com/lukeredpath/LRToolkit
//

extern NSString *const LRUIPopoverControllerDidDismissNotification;

@interface LRPopoverManager : NSObject <UIPopoverControllerDelegate>

@property (nonatomic, retain) UIPopoverController *currentPopoverController;
@property (nonatomic, assign) BOOL permitCurrentPopoverControllerToDismiss;

+ (LRPopoverManager *)sharedManager;

- (void)presentPopoverController:(UIPopoverController *)pc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
- (void)presentPopoverController:(UIPopoverController *)pc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)presentControllerInPopoverController:(UIViewController *)vc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
- (void)presentControllerInPopoverController:(UIViewController *)vc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)presentControllerWithNavigationInPopoverController:(UIViewController *)vc fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
- (void)presentControllerWithNavigationInPopoverController:(UIViewController *)vc fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)dismissCurrentPopoverController:(BOOL)animated;
@end
