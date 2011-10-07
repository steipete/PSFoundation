#import "UITableViewCell+FKLoading.h"
#import "NSObject+AssociatedObjects.h"

static char activityViewKey;
static char previousAccessoryKey;

@interface UITableViewCell ()

// re-define as read/write
@property (nonatomic, retain, readwrite) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UIView *previousAccessory;

@end

@implementation UITableViewCell (FKLoading)

- (void)showLoadingIndicator {
    if ([self.accessoryView isKindOfClass:[UIActivityIndicatorView class]]) {
        return;
    }
    
    // store previous accessoryView
    self.previousAccessory = self.accessoryView;
    
    // set activityIndicator as new accessoryView
    self.activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
    [self.activityView startAnimating];
    
    self.accessoryView = self.activityView;
    [self setNeedsDisplay];
}

- (void)hideLoadingIndicator {
    [self.activityView stopAnimating];
    
    // restore previous state
    self.accessoryView = self.previousAccessory;
    self.activityView = nil;
    self.previousAccessory = nil;
}

- (void)setActivityView:(UIActivityIndicatorView *)activityView {
    [self associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)activityView {
    return (UIActivityIndicatorView *)[self associatedValueForKey:&activityViewKey];
}

- (void)setPreviousAccessory:(UIView *)previousAccessory {
    [self associateValue:previousAccessory withKey:&previousAccessoryKey];
}

- (UIView *)previousAccessory {
    return (UIView *)[self associatedValueForKey:&previousAccessoryKey];
}

@end
