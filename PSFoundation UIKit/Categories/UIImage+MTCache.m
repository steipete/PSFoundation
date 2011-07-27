//
//  UIImage+MTCache.m
//  PSFoundation
//
//  Created by Matthias Tretter on 04.03.11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import "UIImage+MTCache.h"
#import "NSFileManager+PSFoundation.h"

@implementation UIImage (MTCache)

- (BOOL)writeJPEGToFilename:(NSString *)filename quality:(double)quality {
	NSString *path = [[NSFileManager libraryFolder] stringByAppendingPathComponent:filename];
    NSData *jpegRep = UIImageJPEGRepresentation(self, quality);
	return [jpegRep writeToFile:path options:NSAtomicWrite error:nil];
}

@end
