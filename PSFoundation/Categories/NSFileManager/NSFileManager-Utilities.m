/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "NSArray-Utilities.h"
#import "NSFileManager-Utilities.h"

NSString *NSDocumentsFolder() {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *NSLibraryFolder() {
  return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *NSBundleFolder() {
  return [[NSBundle mainBundle] bundlePath];
}

@implementation NSFileManager (Utilities)

+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
  NSString *file;
  NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
  while ((file = [dirEnum nextObject]))
    if ([[file lastPathComponent] isEqualToString:fname])
      return [path stringByAppendingPathComponent:file];
  return nil;
}

+ (NSString *) pathForDocumentNamed: (NSString *) fname
{
  return [NSFileManager pathForItemNamed:fname inFolder:NSDocumentsFolder()];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname
{
  return [NSFileManager pathForItemNamed:fname inFolder:NSBundleFolder()];
}

+ (NSArray *) filesInFolder: (NSString *) path
{
  NSString *file;
  NSMutableArray *results = [NSMutableArray array];
  NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
  while ((file = [dirEnum nextObject]))
  {
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:file] isDirectory: &isDir];
    if (!isDir) [results addObject:file];
  }
  return results;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
  NSString *file;
  NSMutableArray *results = [NSMutableArray array];
  NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
  while ((file = [dirEnum nextObject]))
    if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
      [results addObject:[path stringByAppendingPathComponent:file]];
  return results;
}

+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext
{
  return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:NSDocumentsFolder()];
}

// Case insensitive compare
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
  return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:NSBundleFolder()];
}
@end

