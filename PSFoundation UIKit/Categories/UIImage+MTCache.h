//
//  UIImage+MTCache.h
//  PSFoundation
//
//  Created by Matthias Tretter on 04.03.11.
//  Licensed under MIT. All rights reserved.
//

@interface UIImage (MTCache)

- (BOOL)writeJPEGToFilename:(NSString *)filename quality:(double)quality;

@end
