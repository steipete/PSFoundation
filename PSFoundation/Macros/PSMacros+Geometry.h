//
//  PSMacros+Geometry.h
//  PSFoundation
//
//   - Michael Ash.       2010. BSD.
//   - Dirk Holtwick.
//   - Peter Steinberger. 2010. BSD.
//

// CGRect
CG_INLINE CGRect CGRectClearCoords(CGRect rect) {
    return (CGRect){0, 0, rect.size.width, rect.size.height};
}

// portrait/landscape corrected screen bounds
#define PSAppStatusBarOrientation ([[UIApplication sharedApplication] statusBarOrientation])
#define PSIsPortrait()  UIInterfaceOrientationIsPortrait(PSAppStatusBarOrientation)
#define PSIsLandscape() UIInterfaceOrientationIsLandscape(PSAppStatusBarOrientation)
#define UIInterfaceOrientationsAreCounterpart(o1,o2) (UIInterfaceOrientationIsPortrait(o1) && UIInterfaceOrientationIsPortrait(o2) || UIInterfaceOrientationIsLandscape(o1) && UIInterfaceOrientationIsLandscape(o2))

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
