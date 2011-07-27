//
//  UIImage+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Matthias Tretter. 2010. MIT.
//

@class CLLocation;

@interface UIImage (PSFoundation)

- (NSData *)imageDataWithTagsForLocation:(CLLocation *)location;

@end