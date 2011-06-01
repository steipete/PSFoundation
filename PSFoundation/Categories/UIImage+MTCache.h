//
//  UIImage+MTCache.h
//  PSFoundation
//
//  Created by Matthias Tretter on 04.03.11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (MTCache)

+ (UIImage *)JPEGWithContentsOfFilename:(NSString *)filename;
- (BOOL)writeJPEGToFilename:(NSString *)filename quality:(double)quality;

@end
