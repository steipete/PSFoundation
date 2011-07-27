//
//  NSFileManager+PSFoundation.m
//  PSFoundation
//

#import "NSFileManager+PSFoundation.h"
#import "NSArray+PSFoundation.h"

@implementation NSFileManager (PSFoundation)

+ (NSString *) pathForItemNamed:(NSString *)fname inFolder:(NSString *)path {
    NSError *error = nil;
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (!error) {
        NSString *path = [list match:^BOOL(id obj) {
            return ([[obj lastPathComponent] isEqualToString:fname]);
        }];
        return [path stringByAppendingPathComponent:path];
    }
    return nil;
}

+ (NSString *)pathForDocumentNamed:(NSString *)fname {
    return [NSFileManager pathForItemNamed:fname inFolder:[NSFileManager documentsFolder]];
}

+ (NSString *) pathForBundleItemNamed: (NSString *) fname {
    return [NSFileManager pathForItemNamed:fname inFolder:[NSFileManager bundleFolder]];
}

+ (NSArray *)filesInFolder:(NSString *)path {
    NSError *error = nil;
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (!error) {
        return [list select:^BOOL(id obj) {
            BOOL isDir;
            [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:obj] isDirectory:&isDir];
            return (!isDir);
        }];
    }
    return nil;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *) pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)path {
    NSError *error = nil;
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (!error) {
        return [list select:^BOOL(id obj) {
            return ([[obj pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame);
        }];
    }
    return nil;
}

+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSFileManager documentsFolder]];
}

// Case insensitive compare
+ (NSArray *)pathsForBundleItemsMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSFileManager bundleFolder]];
}

+ (NSString *)documentsFolder {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryFolder {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)bundleFolder {
    return [[NSBundle mainBundle] bundlePath];
}

@end