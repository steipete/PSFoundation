//
//  NSFileManager+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Erica Sadun.        2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//   - Steve Streza.       2010.
//

#import "NSFileManager+PSFoundation.h"
#import "NSArray+Structures.h"

@implementation NSFileManager (PSFoundation)

+ (NSString *) pathForItemNamed:(NSString *)fname inFolder:(NSString *)path {
    NSError *error = nil;
    NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    if (!error) {
        return [path stringByAppendingPathComponent:[list match:^BOOL(id obj) {
            return ([[obj lastPathComponent] isEqualToString:fname]);
        }]];
    }
    return nil;
}

+ (NSString *)pathForDocumentNamed:(NSString *)fname {
    return [NSFileManager pathForItemNamed:fname inFolder:[NSFileManager documentsFolder]];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname {
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
+ (NSArray *)pathsForBundleDocumentsMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:NSBundleFolder()];
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

- (void)getContentsAtPath:(NSString *)path handler:(void (^)(NSData *data, NSError *error))handler {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
		NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:path];
		NSError *error = nil;
		NSMutableData *data = [NSMutableData data];
		
		// create a GCD source using the file descriptor, which will respond whenever the descriptor fires
		dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, [fh fileDescriptor], 0, queue);
		dispatch_source_set_event_handler(source, ^{
			BOOL eof = NO;
			
			// if we get less than this much, we hit end of file, so we can file the callback
			NSUInteger max = 65536;
			NSData *newData = [fh readDataOfLength:max];
			if(!newData || newData.length < max){
				eof = YES;
			}
			[data appendData:newData];
			
			if(eof){
				dispatch_async(dispatch_get_main_queue(), ^{
					handler(data, error);
                    PS_RELEASE(data);
				});
				
				dispatch_source_cancel(source);
                PS_RELEASE(fh);
			}
		});
		dispatch_resume(source);
	});
}

@end