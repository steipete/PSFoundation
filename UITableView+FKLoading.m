#import "UITableView+FKLoading.h"
#import "UITableViewCell+FKLoading.h"
#import "NSObject+AssociatedObjects.h"

static char allowsMultipleIndicatorsKey;
static char cellsShowingIndicatorKey;

@interface UITableView ()

@property (nonatomic, readonly) NSMutableSet *cellsShowingLoadingIndicator;

@end

@implementation UITableView (FKLoading)

- (void)showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    if (!self.allowsMultipleLoadingIndicators) {
        [self hideLoadingIndicators];
    }
    
    [cell showLoadingIndicator];
    [self.cellsShowingLoadingIndicator addObject:indexPath];
}

- (void)hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    [cell hideLoadingIndicator];
    [self.cellsShowingLoadingIndicator removeObject:indexPath];
}

// hides all loading indicators
- (void)hideLoadingIndicators {
    for (NSIndexPath *indexPath in self.cellsShowingLoadingIndicator) {
        [self hideLoadingIndicatorAtIndexPath:indexPath];
    }
}

- (void)setAllowsMultipleLoadingIndicators:(BOOL)allowsMultipleLoadingIndicators {
    [self associateValue:$B(allowsMultipleLoadingIndicators) withKey:&allowsMultipleIndicatorsKey];
}

- (BOOL)allowsMultipleLoadingIndicators {
    return [[self associatedValueForKey:&allowsMultipleIndicatorsKey] boolValue];
}

- (NSMutableSet *)cellsShowingLoadingIndicator {
    NSMutableSet *cells = (NSMutableSet *)[self associatedValueForKey:&cellsShowingIndicatorKey];
    
    // lazy loading
    if (cells == nil) {
        cells = [NSMutableSet set];
        [self associateValue:cells withKey:&cellsShowingIndicatorKey];
    }
    
    return cells;
}

@end
