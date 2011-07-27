//
//  PSMacros+UIKit.h
//  PSFoundation
//
//  Includes code by the following:
//   - Michael Ash.       2010. BSD.
//   - Dirk Holtwick.
//   - Peter Steinberger. 2010. MIT.
//

#include "PSMacros.h"
#import "UIDevice+PSFoundation.h"
#import "CoreGraphics+PSFoundation.h"

// color
#define PSColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define PSCGColor(r, g, b)  PSColor(r, g, b).CGColor
#define PSHexColor(c)       [UIColor colorWithHex:c]
#define PSHexColorAlpha(c)  [UIColor colorWithHex:c alpha:a]
#define PSHexCGColor(c)     PSHexColor(c).CGColor

#if defined(TARGET_IPHONE_SIMULATOR) && defined(DEBUG)
UIKIT_STATIC_INLINE void PSSimulateMemoryWarning(void) {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
}
#else
UIKIT_STATIC_INLINE void PSSimulateMemoryWarning(void) {
    return;
}
#endif

// portrait/landscape corrected screen bounds
#define PSAppStatusBarOrientation()                     ([[UIApplication sharedApplication] statusBarOrientation])
#define PSIsPortrait()                                  UIInterfaceOrientationIsPortrait(PSAppStatusBarOrientation())
#define PSIsLandscape()                                 UIInterfaceOrientationIsLandscape(PSAppStatusBarOrientation())
#define UIInterfaceOrientationsAreCounterpart(o1,o2)    (UIInterfaceOrientationIsPortrait(o1) && UIInterfaceOrientationIsPortrait(o2) || UIInterfaceOrientationIsLandscape(o1) && UIInterfaceOrientationIsLandscape(o2))

CG_INLINE CGRect PSScreenBounds() {
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (PSIsLandscape()) {
        bounds.size.width = [UIScreen mainScreen].bounds.size.height;
        bounds.size.height = [UIScreen mainScreen].bounds.size.width;
    }
    return bounds;
}

CG_INLINE CGFloat PSAppWidth() {
    if (PSIsPortrait()) {
        return [UIScreen mainScreen].bounds.size.width;
    } else {
        return [UIScreen mainScreen].bounds.size.height;
    }
}

#define kRotateOniPad(interfaceOrientation) (isIPad() || interfaceOrientation == UIInterfaceOrientationPortrait)