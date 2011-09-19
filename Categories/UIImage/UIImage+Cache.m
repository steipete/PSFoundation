//
//  UIImage+Cache.m
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "UIImage+Cache.h"

static NSMutableDictionary *UIImageCache;

@implementation UIImage(Cache)

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path {
    if ([[UIScreen mainScreen] scale] == 2.0) {
        NSString *path2x = [[path stringByDeletingLastPathComponent]
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@",
                                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                                            [path pathExtension]]];

        if ([[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithContentsOfFile:path2x];
        }
    }

    return [self initWithContentsOfFile:path];
}


+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path {
    return [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
}

+ (id)cachedImageWithContentsOfFile:(NSString *)path {
    id result = nil;
    @synchronized(UIImageCache) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UIImageCache = [[NSMutableDictionary alloc] init];
        });
        result = [UIImageCache objectForKey:path];
        if (result) {
            return result;
        }

        result = [[[UIImage alloc] initWithContentsOfResolutionIndependentFile:path] autorelease];
        if(result) [UIImageCache setObject:result forKey:path];
    }
    return result;
}

+ (void)clearCache {
    @synchronized(UIImageCache) {
        DDLogInfo(@"Clearing image cache: %d objects", [UIImageCache count]);
        [UIImageCache removeAllObjects];
    }
}

@end
