//
//  UIImage+Cache.h
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface UIImage(Cache)

// http://atastypixel.com/blog/uiimage-resolution-independence-and-the-iphone-4s-retina-display/
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;

// http://stackoverflow.com/questions/1338727/any-way-to-get-a-cached-uiimage-from-my-documents-directory
+ (id)cachedImageWithContentsOfFile:(NSString *)path;
+ (void)clearCache;

@end
