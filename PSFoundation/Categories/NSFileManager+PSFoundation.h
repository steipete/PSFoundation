//
//  NSFileManager+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Erica Sadun.        2009.  BSD.
//   - Peter Steinberger.  2010.  MIT.
//

@interface NSFileManager (PSFoundation)

+ (NSString *)pathForItemNamed:(NSString *)name inFolder:(NSString *)path;
+ (NSString *)pathForDocumentNamed:(NSString *)fname;
+ (NSString *)pathForBundleItemNamed:(NSString *)fname;

+ (NSArray *)pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)path;
+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext;
+ (NSArray *)pathsForBundleItemsMatchingExtension:(NSString *)ext;

+ (NSArray *)filesInFolder:(NSString *) path;

+ (NSString *)documentsFolder;
+ (NSString *)libraryFolder;
+ (NSString *)bundleFolder;

@end