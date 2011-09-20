// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UITableViewCell (FKLoading)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end
