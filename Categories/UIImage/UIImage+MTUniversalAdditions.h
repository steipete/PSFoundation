//
//  UIImage+MTUniversalAdditions.h
//  MTUniversal
//
//  Created by Matthias Tretter on 09.10.10.
//  Copyright 2010 YellowSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (MTUniversalAdditions)

// if current device is iPad, append -iPad to imageName and retrieve that image
+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName;
+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName appendix:(NSString *)appendix;
// append -iPad if on iPad and -L if orientation is Landscape
+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName forOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)deviceSpecificImageNamed:(NSString *)imageName forOrientation:(UIInterfaceOrientation)orientation appendix:(NSString *)appendix;

@end
