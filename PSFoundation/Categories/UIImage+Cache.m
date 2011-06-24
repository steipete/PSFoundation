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
    if ( [UIScreen instancesRespondToSelector:@selector(scale)] && (int)[[UIScreen mainScreen] scale] == 2.0 ) {
        NSString *path2x = [[path stringByDeletingLastPathComponent]
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@",
                                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                                            [path pathExtension]]];

        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithContentsOfFile:path2x];
        }
    }

    return [self initWithContentsOfFile:path];
}

+ (UIImage *)imageWithContentsOfResolutionIndependentFile:(NSString *)path {
    return PS_AUTORELEASE([[UIImage alloc] initWithContentsOfResolutionIndependentFile:path]);
}


+ (id)cachedImageWithContentsOfFile:(NSString *)path {
    id result = nil;
    @synchronized(UIImageCache) {
        if (!UIImageCache)
            UIImageCache = [[NSMutableDictionary alloc] init];
        else {
            result = [UIImageCache objectForKey:path];
            if (result)
                return result;
        }
        result = [[UIImage alloc] initWithContentsOfResolutionIndependentFile:path];
        if (result) [UIImageCache setObject:result forKey:path];
    }
    return PS_AUTORELEASE(result);
}


+ (void)clearCache {
    @synchronized(UIImageCache) {
        DDLogInfo(@"Clearing image cache: %d objects", [UIImageCache count]);
        [UIImageCache removeAllObjects];
    }
}

@end
