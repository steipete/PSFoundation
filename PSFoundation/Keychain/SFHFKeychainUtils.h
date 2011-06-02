//
//  SFHFKeychainUtils.h
//  PSFoundation
//
//  Includes code by the following:
//   - Buzz Andersen.   2008.  MIT.
//   - Jon Crosby.
//   - Mike Malone.
//   - Jonathan Wight.
//

@interface SFHFKeychainUtils : NSObject;

+ (NSString *)getPasswordForUsername:(NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error;
+ (BOOL)storeUsername:(NSString *)username andPassword:(NSString *)password forServiceName:(NSString *)serviceName updateExisting:(BOOL)updateExisting error:(NSError **)error;
+ (BOOL)deleteItemForUsername: (NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error;

@end