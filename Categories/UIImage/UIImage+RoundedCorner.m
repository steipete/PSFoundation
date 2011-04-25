// UIImage+RoundedCorner.m
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.
// Improved to work with retina display on iOS4 by Peter Steinberger

#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"
#import "PSCompatibility.h"

// Private helper methods
@interface UIImage ()
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;
@end

@implementation UIImage (RoundedCorner)

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
  // If the image does not have an alpha layer, add one
    
    // adapt to scale
    cornerSize *= self.scale;

	UIImage *roundedImage = nil;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	IF_IOS4_OR_GREATER(
		UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0); // 0.0 for scale means "correct scale for device's main screen".
		CGImageRef sourceImg = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale)); // cropping happens here.

    // Create a clipping path with rounded corners
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, self.size.width - borderSize * 2, self.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);

		roundedImage = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:self.imageOrientation]; // create cropped UIImage.
		[roundedImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)]; // the actual scaling happens here, and orientation is taken care of automatically.
		CGImageRelease(sourceImg);
		roundedImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
  )
#endif
  if (!roundedImage) {
    // Try older method.
    UIImage *image = [self imageWithAlpha];

    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));

    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);

    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);

    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);

    // Create a UIImage from the CGImage
    roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
  }
  return roundedImage;
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
  if (ovalWidth == 0 || ovalHeight == 0) {
    CGContextAddRect(context, rect);
    return;
  }
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
  CGContextScaleCTM(context, ovalWidth, ovalHeight);
  CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
  CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
  CGContextMoveToPoint(context, fw, fh/2);
  CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
  CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
  CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
  CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

@end
