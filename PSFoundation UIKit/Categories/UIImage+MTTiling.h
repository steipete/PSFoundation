//
//  UIImage+MTTiling.h
//  PSFoundation
//
//  Created by Matthias Tretter on 15.03.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from:
//  http://www.cimgf.com/2011/03/01/subduing-catiledlayer/

@interface UIImage (MTTiling)

- (void)saveTilesOfSize:(CGSize)size
            toDirectory:(NSString*)directoryPath
            usingPrefix:(NSString*)prefix;

@end
