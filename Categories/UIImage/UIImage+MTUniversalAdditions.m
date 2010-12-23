//
//  UIImage+MTUniversalAdditions.m
//  MTUniversal
//
//  Created by Matthias Tretter on 09.10.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import "UIImage+MTUniversalAdditions.h"
#import "MTUniversalHelper.h"


@implementation UIImage (MTUniversalAdditions)

+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName
{
	UIImage *image = [UIImage imageNamed:MTDeviceSpecificImageName(imageName)];

	// fallback: no iPad-specific image? -> use iPhone-image without iPad-Appendix
	if (image == nil) {
		image = [UIImage imageNamed:imageName];
	}

	return image;
}


+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName forOrientation:(UIInterfaceOrientation)orientation
{
	UIImage *image = [UIImage imageNamed:MTDeviceSpecificImageNameForOrientation(imageName,orientation)];

	// fallback: no specific image for orientation? -> use normal one
	if (image == nil) {
		image = [UIImage deviceSpecificImageNamed:imageName];
	}

	return image;
}

@end
