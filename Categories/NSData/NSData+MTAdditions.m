//
//  NSData+MTAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 27.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "NSData+MTAdditions.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
#import "PSCompatibility.h"




@implementation NSData (MTAdditions)

// set metadata for images picked with UIImagePickerController

- (NSData *)dataWithEXIFUsingLocation:(CLLocation *)location {
	IF_IOS4_OR_GREATER
	(
	 NSMutableData* newJPEGData = [[[NSMutableData alloc] init] autorelease];
	 NSMutableDictionary* exifDict = [[NSMutableDictionary alloc] init];
	 NSMutableDictionary* locDict = [[NSMutableDictionary alloc] init];
	 NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	 [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];

	 CGImageSourceRef img = CGImageSourceCreateWithData((CFDataRef)self, NULL);
	 CLLocationDegrees exifLatitude = location.coordinate.latitude;
	 CLLocationDegrees exifLongitude = location.coordinate.longitude;

	 NSString* datetime = [dateFormatter stringFromDate:location.timestamp];

	 [exifDict setObject:datetime forKey:(NSString*)kCGImagePropertyExifDateTimeOriginal];
	 [exifDict setObject:datetime forKey:(NSString*)kCGImagePropertyExifDateTimeDigitized];

	 [locDict setObject:location.timestamp forKey:(NSString*)kCGImagePropertyGPSTimeStamp];

	 if (exifLatitude < 0.0) {
		 exifLatitude = exifLatitude*(-1);
		 [locDict setObject:@"S" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
	 } else {
		 [locDict setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
	 }

	 [locDict setObject:[NSNumber numberWithFloat:exifLatitude] forKey:(NSString*)kCGImagePropertyGPSLatitude];

	 if (exifLongitude < 0.0) {
		 exifLongitude=exifLongitude*(-1);
		 [locDict setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
	 } else {
		 [locDict setObject:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
	 }

	 [locDict setObject:[NSNumber numberWithFloat:exifLongitude] forKey:(NSString*) kCGImagePropertyGPSLatitude];

	 NSDictionary * properties = [[NSDictionary alloc] initWithObjectsAndKeys:
								  locDict, (NSString*)kCGImagePropertyGPSDictionary,
								  exifDict, (NSString*)kCGImagePropertyExifDictionary, nil];
	 CGImageDestinationRef dest = CGImageDestinationCreateWithData((CFMutableDataRef)newJPEGData, CGImageSourceGetType(img), 1, NULL);
	 CGImageDestinationAddImageFromSource(dest, img, 0, (CFDictionaryRef)properties);
	 CGImageDestinationFinalize(dest);

	 [properties release];

	 CFRelease(img);
	 CFRelease(dest);

	 [exifDict release];
	 [locDict release];
	 [dateFormatter release];

	 return newJPEGData;
	)

	// functionality not available on 3.x, just return original data
	return self;
}


@end
