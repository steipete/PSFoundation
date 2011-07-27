//
//  UIImage+MTUniversalAdditions.m
//  MTUniversal
//
//  Created by Matthias Tretter on 09.10.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import "UIImage+MTUniversalAdditions.h"

@implementation UIImage (MTUniversalAdditions)

+ (UIImage *)imageNamed:(NSString *)name forOrientation:(UIInterfaceOrientation)orientation {
    NSString *newName = name;
    NSArray *parts = [name componentsSeparatedByString:@"."];
	NSString *orientationAppendix = UIInterfaceOrientationIsLandscape(orientation) ? @"-L" : @"";
    
	if (parts.count == 2)
		newName = [NSString stringWithFormat:@"%@%@.%@", [parts objectAtIndex:0], orientationAppendix, [parts objectAtIndex:1]];
	else if (parts.count == 1)
		newName = [NSString stringWithFormat:@"%@%@.png", [parts objectAtIndex:0], orientationAppendix];
    
    UIImage *image = [UIImage imageNamed:newName];
	if (!image)
		image = [UIImage imageNamed:name];    
	return image;    
}

@end
