//
//  NSData+MTAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 27.12.10.
//  Licensed under MIT. All rights reserved.
//

#import "NSData+MTAdditions.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>

@implementation NSData (MTAdditions)

// set metadata for images picked with UIImagePickerController

- (NSData *)dataWithEXIFUsingLocation:(CLLocation *)location {
    IF_IOS4_OR_GREATER(
        NSMutableData *newJPEGData = [NSMutableData new];
        NSMutableDictionary *exifDict = [NSMutableDictionary new];
        NSMutableDictionary *locDict = [NSMutableDictionary new];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];

        CGImageSourceRef img = CGImageSourceCreateWithData((__bridge CFDataRef)self, NULL);
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
        CFMutableDataRef jpegData = (__bridge CFMutableDataRef)newJPEGData;
        CGImageDestinationRef dest = CGImageDestinationCreateWithData(jpegData, CGImageSourceGetType(img), 1, NULL);
        CGImageDestinationAddImageFromSource(dest, img, 0, (__bridge CFDictionaryRef)properties);
        CGImageDestinationFinalize(dest);

        CFRelease(img);
        CFRelease(dest);
                       
        PS_RELEASE(exifDict);
        PS_RELEASE(locDict);
        PS_RELEASE(dateFormatter);

        return PS_AUTORELEASE(newJPEGData);
	)

	// functionality not available on 3.x, just return original data
	return self;
}


@end
