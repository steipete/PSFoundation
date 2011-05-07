//
//  UIImage+ProportionalFill.m
//
//  Created by Matt Gemmell on 20/08/2008.
//  Copyright 2008 Instinctive Code.
//  Heavily fixed and modified by Peter Steinberger 24/04/2010
//

#import "UIImage+ProportionalFill.h"
#import "PSMacros.h"

@implementation UIImage (MGProportionalFill)

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};

CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
};

- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod honorScaleFactor:(BOOL)honorScaleFactor {
    
	float imageScaleFactor = 1.0;
    if (honorScaleFactor) {
        imageScaleFactor = [self scale];
    }
    
    float sourceWidth = [self size].width * imageScaleFactor;
    float sourceHeight = [self size].height * imageScaleFactor;
    float targetWidth = fitSize.width;
    float targetHeight = fitSize.height;
    BOOL cropping = !(resizeMethod == MGImageResizeScale);
    
    // adapt rect based on source image size
    //DDLogInfo(@"imageOrientation: %d", self.imageOrientation);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:    // button top
        case UIImageOrientationRight:   // button bottom
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: { 
            ps_swapf(sourceWidth, sourceHeight);
            ps_swapf(targetWidth, targetHeight);
        }break;
            
        case UIImageOrientationUp:     // button left
        case UIImageOrientationDown:   // button right
        default: {             // works in default
        }break;
    }
    
    // Calculate aspect ratios
    float sourceRatio = sourceWidth / sourceHeight;
    float targetRatio = targetWidth / targetHeight;
    
    // Determine what side of the source image to use for proportional scaling
    BOOL scaleWidth = (sourceRatio <= targetRatio);
    // Deal with the case of just scaling proportionally to fit, without cropping
    scaleWidth = (cropping) ? scaleWidth : !scaleWidth;
    
    // Proportionally scale source image
    float scalingFactor, scaledWidth, scaledHeight;
    if (scaleWidth) {
        scalingFactor = 1.0 / sourceRatio;
        scaledWidth = targetWidth;
        scaledHeight = round(targetWidth * scalingFactor);
    } else {
        scalingFactor = sourceRatio;
        scaledWidth = round(targetHeight * scalingFactor);
        scaledHeight = targetHeight;
    }
    float scaleFactor = scaledHeight / sourceHeight;
    
    // Calculate compositing rectangles
    CGRect sourceRect, destRect;
    if (cropping) {
        destRect = CGRectMake(0, 0, targetWidth, targetHeight);
        float destX, destY;
        if (resizeMethod == MGImageResizeCrop) {
            // Crop center
            destX = round((scaledWidth - targetWidth) / 2.0);
            destY = round((scaledHeight - targetHeight) / 2.0);
        } else if (resizeMethod == MGImageResizeCropStart) {
            // Crop top or left (prefer top)
            if (scaleWidth) {
                // Crop top
                destX = 0.0;
                destY = 0.0;
            } else {
                // Crop left
                destX = 0.0;
                destY = round((scaledHeight - targetHeight) / 2.0);
            }
        } else if (resizeMethod == MGImageResizeCropEnd) {
            // Crop bottom or right
            if (scaleWidth) {
                // Crop bottom
                destX = round((scaledWidth - targetWidth) / 2.0);
                destY = round(scaledHeight - targetHeight);
            } else {
                // Crop right
                destX = round(scaledWidth - targetWidth);
                destY = round((scaledHeight - targetHeight) / 2.0);
            }
        }
        sourceRect = CGRectMake(destX / scaleFactor, destY / scaleFactor,
                                targetWidth / scaleFactor, targetHeight / scaleFactor);
    } else {
        sourceRect = CGRectMake(0, 0, sourceWidth, sourceHeight);
        destRect = CGRectMake(0, 0, scaledWidth, scaledHeight);
    }
    
    // Create appropriately modified image.
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(destRect.size, NO, honorScaleFactor ? 0.0 : 1.0); // 0.0 for scale means "correct scale for device's main screen".
    CGImageRef sourceImg = CGImageCreateWithImageInRect([self CGImage], sourceRect); // cropping happens here.
    image = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:self.imageOrientation]; //  create cropped UIImage.
    //DDLogInfo(@"image size: %@", NSStringFromCGSize(image.size));
    [image drawInRect:destRect]; // the actual scaling happens here, and orientation is taken care of automatically.
    CGImageRelease(sourceImg);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod {
    return [self imageToFitSize:fitSize method:resizeMethod honorScaleFactor:YES];
}


- (UIImage *)imageCroppedToFitSize:(CGSize)fitSize {
    return [self imageToFitSize:fitSize method:MGImageResizeCrop honorScaleFactor:YES];
}


- (UIImage *)imageScaledToFitSize:(CGSize)fitSize {
    return [self imageToFitSize:fitSize method:MGImageResizeScale honorScaleFactor:YES];
}


@end
