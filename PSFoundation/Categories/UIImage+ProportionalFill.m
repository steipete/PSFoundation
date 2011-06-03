//
//  UIImage+ProportionalFill.m
//  PSFoundation
//
//  Uses method names inspired by Matt Gemmell.
//

#import "UIImage+ProportionalFill.h"
#import "NYXImagesUtilities.h"

@implementation UIImage (ProportionalFill)

- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod honorScaleFactor:(BOOL)honorScaleFactor {
    if (resizeMethod == MGImageResizeScale)
        return [self scaleToFitSize:fitSize];
    else if (resizeMethod == MGImageResizeCrop)
        return [self cropToSize:fitSize];
    else if (resizeMethod == MGImageResizeCropStart)
        return [self cropToSize:fitSize usingMode:NYXCropModeTopLeft];
    else if (resizeMethod == MGImageResizeCropEnd)
        return [self cropToSize:fitSize usingMode:NYXCropModeBottomRight];
    return self;
}

- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod {
    if (resizeMethod == MGImageResizeScale)
        return [self scaleToFitSize:fitSize];
    else if (resizeMethod == MGImageResizeCrop)
        return [self cropToSize:fitSize];
    else if (resizeMethod == MGImageResizeCropStart)
        return [self cropToSize:fitSize usingMode:NYXCropModeTopLeft];
    else if (resizeMethod == MGImageResizeCropEnd)
        return [self cropToSize:fitSize usingMode:NYXCropModeBottomRight];
    return self;
}


- (UIImage *)imageCroppedToFitSize:(CGSize)fitSize {
    return [self cropToSize:fitSize];
}


- (UIImage *)imageScaledToFitSize:(CGSize)fitSize {
    return [self scaleToFitSize:fitSize];
}


@end
