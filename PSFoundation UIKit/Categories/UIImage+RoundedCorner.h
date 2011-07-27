//
//  UIImage+RoundedCorner.h
//  PSFoundation
//
//  Includes code by the following:
//   - Trevor Harmon.     2009. Public domain.
//   - Björn Sållarp.     2009. Used with permission.
//   - Peter Steinberger. 2010. MIT.
//
//  References:
//   - http://blog.sallarp.com/iphone-uiimage-round-corners/
//

@interface UIImage (PSRoundedCorners)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
