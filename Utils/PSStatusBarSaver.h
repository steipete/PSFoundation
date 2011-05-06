//
//  PSStatusBarSaver.h
//  PSFoundation
//
//  Created by Peter Steinberger on 21.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//


@interface PSStatusBarSaver : NSObject {
  UIStatusBarStyle savedStatusBarStyle_;
}

@property (nonatomic, assign) UIStatusBarStyle savedStatusBarStyle;

+ (void)captureStatusBar;
+ (void)captureStatusBarAndSetTo:(UIStatusBarStyle)newStyle;
+ (void)captureStatusBarAndSetTo:(UIStatusBarStyle)newStyle animated:(BOOL)animated;
+ (void)restoreStatusBar;
+ (void)restoreStatusBarAnimated:(BOOL)animated;

@end
