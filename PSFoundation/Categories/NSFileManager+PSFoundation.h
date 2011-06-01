//
//  NSFileManager+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Erica Sadun.  2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//   - Steve Streza.  2010.
//

@interface NSFileManager (PSFoundation)

+ (NSString *)pathForItemNamed: (NSString *) fname inFolder: (NSString *) path;
+ (NSString *)pathForDocumentNamed: (NSString *) fname;
+ (NSString *)pathForBundleDocumentNamed: (NSString *) fname;

+ (NSArray *)pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)path;
+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext;
+ (NSArray *)pathsForBundleDocumentsMatchingExtension:(NSString *)ext;

+ (NSArray *)filesInFolder:(NSString *) path;

+ (NSString *)documentsFolder;
+ (NSString *)libraryFolder;
+ (NSString *)bundleFolder;

- (void)getContentsAtPath:(NSString *)path handler:(void (^)(NSData *data, NSError *error))handler;

@end