//
//  MTUniversalHelper.m
//  PSFoundation
//
//  Created by Matthias Tretter on 09.10.10.
//  Copyright 2010 @myell0w. All rights reserved.
//

#import "MTUniversalHelper.h"

#define kIPadAppendix			@"@iPad"
#define kIPadLandscapeAppendix  @"-L"

///////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Functions for managing device-specific Resources on iPhone/iPad
///////////////////////////////////////////////////////////////////////////////////////////////////////

NSString* MTDeviceSpecificImageName(NSString *imageName) {
	return MTDeviceSpecificImageNameWithAppendix(imageName, kIPadAppendix);
}

NSString* MTDeviceSpecificImageNameWithAppendix(NSString *imageName, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = isIPad() ? appendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@.%@", [parts objectAtIndex:0], iPadAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@.png", [parts objectAtIndex:0], iPadAppendix];
	}
    
	return nil;
}

NSString* MTDeviceSpecificImageNameForOrientation(NSString *imageName, UIInterfaceOrientation orientation) {
	return MTDeviceSpecificImageNameForOrientationWithAppendix(imageName, orientation, kIPadAppendix);
}

NSString* MTDeviceSpecificImageNameForOrientationWithAppendix(NSString *imageName, UIInterfaceOrientation orientation, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = isIPad() ? appendix : @"";
	// when on iPad and orientation is Landscape, append "-iPad-L"
	NSString *orientationAppendix = isIPad() && UIInterfaceOrientationIsLandscape(orientation) ? kIPadLandscapeAppendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@%@.%@", [parts objectAtIndex:0], iPadAppendix, orientationAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@%@.png", [parts objectAtIndex:0], iPadAppendix, orientationAppendix];
	}
    
	return nil;
}

NSString* MTNibName(NSString *name) {
	// when on iPad, append "-iPad"
	NSString *nibName = isIPad() ? name : [name stringByAppendingString:kIPadAppendix];

	// fallback: no iPad-specific nib file? -> use iPhone-Nib
	if([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"] == nil) {
		// even no iPhone-nib? -> use no nib => return nil
		if([[NSBundle mainBundle] pathForResource:name ofType:@"nib"] == nil) {
			return nil;
		}

		return name;
	}

	return nibName;
}
