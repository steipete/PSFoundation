//
//  UIImage+PSFoundation.m
//  PSFoundation
//

#import "UIImage+PSFoundation.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>

@implementation UIImage (PSFoundation)

- (NSData *)imageDataWithTagsForLocation:(CLLocation *)location {
    NSMutableData *newJPEGData = [NSMutableData new];
    NSMutableDictionary *exifDict = [NSMutableDictionary new];
    NSMutableDictionary *locDict = [NSMutableDictionary new];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];

    CGImageSourceRef img = CGImageSourceCreateWithData((CFDataRef)UIImageJPEGRepresentation(self, 1.0), NULL);
    CLLocationDegrees exifLatitude = location.coordinate.latitude;
    CLLocationDegrees exifLongitude = location.coordinate.longitude;
    
    NSString* datetime = [dateFormatter stringFromDate:location.timestamp];
    
    [exifDict setObject:datetime forKey:(NSString *)kCGImagePropertyExifDateTimeOriginal];
    [exifDict setObject:datetime forKey:(NSString *)kCGImagePropertyExifDateTimeDigitized];
    
    [locDict setObject:location.timestamp forKey:(NSString *)kCGImagePropertyGPSTimeStamp];
    
    if (exifLatitude < 0.0) {
        exifLatitude = exifLatitude*(-1);
        [locDict setObject:@"S" forKey:(NSString *)kCGImagePropertyGPSLatitudeRef];
    } else {
        [locDict setObject:@"N" forKey:(NSString *)kCGImagePropertyGPSLatitudeRef];
    }
    
    [locDict setObject:[NSNumber numberWithFloat:exifLatitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];
    
    if (exifLongitude < 0.0) {
        exifLongitude=exifLongitude*(-1);
        [locDict setObject:@"W" forKey:(NSString *)kCGImagePropertyGPSLongitudeRef];
    } else {
        [locDict setObject:@"E" forKey:(NSString *)kCGImagePropertyGPSLongitudeRef];
    }
    
    [locDict setObject:[NSNumber numberWithFloat:exifLongitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];
    
    NSDictionary *properties = XDICT(locDict, kCGImagePropertyGPSDictionary, exifDict, kCGImagePropertyExifDictionary);
    CGImageDestinationRef dest = CGImageDestinationCreateWithData((CFMutableDataRef)newJPEGData, CGImageSourceGetType(img), 1, NULL);
    CGImageDestinationAddImageFromSource(dest, img, 0, (CFDictionaryRef)properties);
    CGImageDestinationFinalize(dest);
    
    CFRelease(img);
    CFRelease(dest);
    
    [exifDict release];
    [locDict release];
    [dateFormatter release];
    
    return [newJPEGData autorelease];
   
}

@end