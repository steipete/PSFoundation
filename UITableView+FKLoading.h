// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UITableView (FKLoading)

@property (nonatomic, assign) BOOL allowsMultipleLoadingIndicators;

- (void)showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
- (void)hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
// hides all loading indicators
- (void)hideLoadingIndicators;

@end
