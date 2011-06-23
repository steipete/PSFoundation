//
//  UIToolbar+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Facebook.           2009.  Apache.
//   - Peter Steinberger.  2010.  MIT.
//

#import "UIView+Sizes.h"

@implementation UIToolbar (PSFoundation)

#define kToolBarHeight 44
#define kToolBarExtraMargin 7

+ (UIToolbar *)ps_customToolbarForView:(UIView *)view {
    UIToolbar __ps_autoreleasing *toolbar = PS_AUTORELEASE([[UIToolbar alloc] initWithFrame:
                           CGRectMake(0, view.size.height - kToolBarHeight, view.width, kToolBarHeight)]);
    
    // UIToolbar has a weird margin. this *slightly* expands the toolbar to look consistent with the navbar
    toolbar.width = toolbar.width + kToolBarExtraMargin * 2;
    toolbar.left = toolbar.left - kToolBarExtraMargin;
    
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth; 
    [view addSubview:toolbar];
    return toolbar;
}

- (UIBarButtonItem *)itemWithTag:(NSInteger)tag {
    return [self.items match:^BOOL(id obj) {
        if ([obj tag] == tag)
            return YES;
        return NO;
    }];
}

@end