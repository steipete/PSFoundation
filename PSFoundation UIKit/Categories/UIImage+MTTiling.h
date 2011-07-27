//
//  UIImage+MTTiling.h
//  PSFoundation
//
//  Created by Matthias Tretter.
//  Licensed under MIT.  All rights reserved.
//
//  References:
//   - http://www.cimgf.com/2011/03/01/subduing-catiledlayer/
//

@interface UIImage (MTTiling)

- (void)saveTilesOfSize:(CGSize)size
            toDirectory:(NSString*)directoryPath
            usingPrefix:(NSString*)prefix;

@end
