//
//  PSKeychain.h
//  PSFoundation
//
//  Includes code by the following:
//   - Buzz Andersen.     2008. MIT.
//   - Sam Soffes.        2011. Public domain.
//   - Zachary Waldowski. 2011. MIT.
//

@interface PSKeychain : NSObject

+ (NSString *)passwordForService:(NSString *)serviceName username:(NSString *)accountName;
+ (NSString *)passwordForService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error;

+ (BOOL)deletePasswordForService:(NSString *)serviceName username:(NSString *)accountName;
+ (BOOL)deletePasswordForService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error;

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName username:(NSString *)accountName;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error;

@end