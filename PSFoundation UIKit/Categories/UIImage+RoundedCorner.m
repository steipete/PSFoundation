//
//  UIImage+RoundedCorner.m
//  PSFoundation
//
//  Includes code by the following:
//   - Trevor Harmon.     2009. Public domain.
//   - Björn Sållarp.     2009. Used with permission.
//   - Peter Steinberger. 2010. MIT.
//

#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

CG_INLINE void PSAddRoundedRectToPath(CGContextRef context, CGRect rect, CGFloat ovalWidth, CGFloat ovalHeight) {
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

@implementation UIImage (PSRoundedCorners)

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    UIImage *startImage = nil, *roundedImage = nil;
    if (self.hasAlpha)
        startImage = self;
    else
        startImage = [self imageWithAlpha];
    
    UIGraphicsBeginImageContextWithOptions(startImage.size, NO, 0.0); // 0.0 for scale means "correct scale for device's main screen".
    CGImageRef sourceImg = CGImageCreateWithImageInRect([self CGImage], CGRectMake(0, 0, startImage.size.width * self.scale, startImage.size.height * startImage.scale)); // cropping happens here.
    
    // Create a clipping path with rounded corners
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    PSAddRoundedRectToPath(context, CGRectMake(borderSize, borderSize, startImage.size.width - borderSize * 2, startImage.size.height - borderSize * 2), cornerSize, cornerSize);
    CGContextClosePath(context);
    CGContextClip(context);
    
    roundedImage = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:startImage.imageOrientation]; // create cropped UIImage.
    [roundedImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)]; // the actual scaling happens here, and orientation is taken care of automatically.
    CGImageRelease(sourceImg);
    roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

@end
