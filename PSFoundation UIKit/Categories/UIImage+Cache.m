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
        result = [[UIImage alloc] initWithContentsOfFile:path];
        if (result) [UIImageCache setObject:result forKey:path];
    }
    return [result autorelease];
}


+ (void)clearCache {
    @synchronized(UIImageCache) {
        DDLogInfo(@"Clearing image cache: %d objects", [UIImageCache count]);
        [UIImageCache removeAllObjects];
    }
}

@end
