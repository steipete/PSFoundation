//
//  CoreGraphics+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.     2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//   - Matthias Tretter.   2011.
//   - Zachary Waldowski.  2011.  MIT.
//
//  References:
//   - http://iphonedevelopment.blogspot.com/2011/02/couple-cgaffinetransform-goodies.html
//

#define UIViewAutoresizingFlexibleMargins UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
#define UIViewAutoresizingFlexibleSize UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

CG_INLINE CGRect CGRectClearCoords(CGRect rect) {
    return (CGRect){ 0, 0, rect.size.height, rect.size.width };
}

CG_INLINE CGRect CGRectBySwapping(CGRect rect) {
    return (CGRect){ rect.origin.x, rect.origin.y, rect.size.height, rect.size.width };
}

CG_INLINE CGRect CGRectReposition(CGRect rect, CGFloat newX, CGFloat newY) {
    return (CGRect){ newX, newY, rect.size.width, rect.size.height };
}

CG_INLINE CGRect CGRectInsetBy(CGRect rect, CGFloat left, CGFloat top, CGFloat right, CGFloat bottom) {
    return (CGRect){ rect.origin.x + left, rect.origin.y + top, rect.size.width - left - right, rect.size.height - top - bottom };
}

CG_INLINE CGRect CGRectOffsetBy(CGRect rect, CGFloat x, CGFloat y) {
    return (CGRect){ rect.origin.x + x, rect.origin.y + y, rect.size.width, rect.size.height };
}

CG_INLINE CGFloat DIWW(CGFloat width, CGFloat baseWidth, CGFloat actualWidth) {
	return floorf((width * actualWidth) / baseWidth);
}

CG_INLINE CGFloat DIW(CGFloat width) {
	return DIWW(width, 320.0f, UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width);
}

// returns a matrix that rotates and translates at one time
CG_INLINE CGAffineTransform CGAffineTransformMakeRotateTranslate(CGFloat angle, CGFloat dx, CGFloat dy) {
    return (CGAffineTransform){ cosf(angle), sinf(angle), -sinf(angle), cosf(angle), dx, dy};
}

// returns a matrix that scales and translates at one time
CG_INLINE CGAffineTransform CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat dx, CGFloat dy) {
    return (CGAffineTransform){ sx, 0.f, 0.f, sy, dx, dy};
}