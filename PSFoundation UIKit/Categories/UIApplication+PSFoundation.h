//
//  UIApplication+PSFoundation.h
//  PSFoundation
//
//  Created by Shaun Harrison.
//  Licensed under MIT; found in LICENSES/MIT
//

@interface UIApplication (PSFoundation)

/*
 * Sets the status bar style as well as the key window background color
 * UIStatusBarStyleDefault will result in a white background color
 * UIStatusBarStyleBlackTranslucent/Opaque will result in a black background color
 */
- (void)setApplicationStyle:(UIStatusBarStyle)style animated:(BOOL)animated;

@property (nonatomic, assign) NSInteger networkActivityCount;

+ (void)incrementNetworkActivityCount;
+ (void)decrementNetworkActivityCount;

@end
