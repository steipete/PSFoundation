//
//  UIImage+ProportionalFill.h
//  PSFoundation
//
//  Uses method names inspired by Matt Gemmell.
//
//  References:
//   - http://mattgemmell.com/2010/07/05/mgimageutilities
//

@interface UIImage (ProportionalFill)

typedef enum {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

// modified by @steipete
- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod honorScaleFactor:(BOOL)honorScaleFactor DEPRECATED_ATTRIBUTE;
- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod DEPRECATED_ATTRIBUTE;
- (UIImage *)imageCroppedToFitSize:(CGSize)size DEPRECATED_ATTRIBUTE; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size DEPRECATED_ATTRIBUTE; // uses MGImageResizeScale

@end
