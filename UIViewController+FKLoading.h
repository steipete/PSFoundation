// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIViewController (FKLoading)

@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityView;

- (void)showCenteredLoadingIndicator;
- (void)showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace;
- (void)showLoadingIndicatorInNavigationBar;
- (void)hideLoadingIndicator;

@end
