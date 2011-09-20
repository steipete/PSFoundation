#import "UIViewController+FKLoading.h"
#import "NSObject+AssociatedObjects.h"


#define kFKActivityViewMaxSize      37.f

static char activityViewKey;
static char replacedObjectKey;

static CGRect FKCenteredSquareInRectConstrainedToSize(CGRect rect, CGFloat size);

@interface UIViewController ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) id replacedObject;

@end

@implementation UIViewController (FKLoading)

- (void)setActivityView:(UIActivityIndicatorView *)activityView {
    [self associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)activityView {
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self associatedValueForKey:&activityViewKey];
    
    // create activityView when it is first read
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView = activityView;
    }
    
    return activityView;
}

- (void)setReplacedObject:(id)replacedObject {
    [self associateValue:replacedObject withKey:&replacedObjectKey];
}

- (id)replacedObject {
    return [self associatedValueForKey:&replacedObjectKey];
}

- (void)showCenteredLoadingIndicator {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    
    // center activityView
    CGRect activityFrame = activityView.frame; 
    
    activityFrame.origin.x = (self.view.bounds.size.width - activityFrame.size.width) / 2.;
    activityFrame.origin.y = (self.view.bounds.size.height - activityFrame.size.height) / 2.;
    
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.frame = CGRectIntegral(activityFrame);
    activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.view addSubview:activityView];
    [activityView startAnimating];
}

- (void)showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace {
    [self hideLoadingIndicator];
    
    UIActivityIndicatorView *activityView = self.activityView;
    
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    // TODO: Resizing currently seems broken in iOS 5, we maybe have to roll our own activityIndicatorView
    activityView.frame = FKCenteredSquareInRectConstrainedToSize(viewToReplace.frame, kFKActivityViewMaxSize);
    activityView.autoresizingMask = viewToReplace.autoresizingMask;
    
    viewToReplace.alpha = 0.f;
    self.replacedObject = viewToReplace;
    
    [self.view addSubview:activityView];
    [activityView startAnimating];
}

- (void)showLoadingIndicatorInNavigationBar {
    [self hideLoadingIndicator];
    
    // initing the loading view
    UIActivityIndicatorView *activityView = self.activityView;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 24.f, 26.f)];
    UIBarButtonItem *barButtonItemToReplace = self.navigationItem.rightBarButtonItem;
    
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activityView.autoresizingMask = UIViewAutoresizingNone;
    activityView.frame = CGRectMake(0.f, 2.f, 20.f, 20.f);
    [backgroundView addSubview:activityView];
    
    self.replacedObject = barButtonItemToReplace;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
    
    [activityView startAnimating];
}

- (void)hideLoadingIndicator {
    id replacedObject = self.replacedObject;
    UIActivityIndicatorView *activityView = self.activityView;
    
    // ActivityView was in NavigationBar
    if ([replacedObject isKindOfClass:[UIBarButtonItem class]]) {
        [activityView stopAnimating];
        self.navigationItem.rightBarButtonItem = replacedObject;
        return;
    } 
    
    // ActivityView was displayed instead of another view
    else if ([replacedObject isKindOfClass:[UIView class]]) {
        [replacedObject setAlpha:1.f];
    }
    
    [activityView stopAnimating];
    [activityView removeFromSuperview];
}

@end


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helper Functions
////////////////////////////////////////////////////////////////////////

static CGRect FKCenteredSquareInRectConstrainedToSize(CGRect rect, CGFloat size) {
    CGRect centeredSquare = rect;
    CGFloat xInset = 0.f;
    CGFloat yInset = 0.f;
    
    // make a centered square
    if (CGRectGetWidth(centeredSquare) < CGRectGetHeight(centeredSquare)) {
        yInset = (CGRectGetHeight(centeredSquare) - CGRectGetWidth(centeredSquare))/2;
    } else {
        xInset = (CGRectGetWidth(centeredSquare) - CGRectGetHeight(centeredSquare))/2;
    }
    
    centeredSquare = CGRectInset(centeredSquare, xInset, yInset);
    
    // limit size
    if (CGRectGetWidth(centeredSquare) > size) {
        centeredSquare = CGRectInset(centeredSquare, (CGRectGetWidth(centeredSquare)-size)/2,(CGRectGetHeight(centeredSquare) - size)/2);
    }
    
    // use integral coordinates to prohibit blurring
    return CGRectIntegral(centeredSquare);
}

