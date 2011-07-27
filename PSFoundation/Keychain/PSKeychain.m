//
//  PSKeychain.m
//  PSFoundation
//

#import "PSKeychain.h"
#import <Security/Security.h>
#import "NSError+SCMethods.h"
#import "NSString+PSFoundation.h"

static NSString *kPSKeychainErrorDomain = @"PSKeychainErrorDomain";

@implementation PSKeychain

+ (NSString *)passwordForService:(NSString *)serviceName username:(NSString *)accountName {
    return [self passwordForService:serviceName username:accountName error:nil];
}

+ (NSString *)passwordForService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error {
    if (accountName.empty || serviceName.empty) {
        if (error) *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:-1001 description:@"Invalid arguments; missing username or service name."];
        return nil;
    }
    
    CFTypeRef resultData = NULL;
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrAccount, accountName);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    CFDictionaryAddValue(query, kSecReturnData, kCFBooleanTrue);
    CFDictionaryAddValue(query, kSecMatchLimit, kSecMatchLimitOne);
    OSStatus status = SecItemCopyMatching(query, &resultData);
    CFRelease(query);
    
    if (status != noErr) {
        if (error) {
            if (status == errSecItemNotFound)
                *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:status description:@"No password found for the given username and service name."];
            else if (!resultData || !CFDataGetLength(resultData))
                *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:-1999 description:@"Password data not retrievable for key.  Please try again."];
            else
                *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:status description:@"Unknown error in retrieving password data."];
        }

        if (resultData != NULL)
			CFRelease(resultData);
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:(NSData *)resultData encoding:NSUTF8StringEncoding];
    CFRelease(resultData);
    return [string autorelease]; 
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName username:(NSString *)accountName {
    return [self deletePasswordForService:serviceName username:accountName error:nil];
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error {
    if (accountName.empty || serviceName.empty) {
        if (error) *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:-1001 description:@"Invalid arguments; missing username or service name."];
        return NO;
    }
    
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrAccount, accountName);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    OSStatus status = SecItemDelete(query);
    CFRelease(query);
    
    if (status != noErr) {
        if (error)
            *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:status description:@"An unknown error occurred while deleting the password."];
        return NO;
    }
    
    return YES;    
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName username:(NSString *)accountName {
    return [self setPassword:password forService:serviceName username:accountName error:nil];
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName username:(NSString *)accountName error:(NSError **)error {
    if (accountName.empty || serviceName.empty) {
        if (error) *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:-1001 description:@"Invalid arguments; missing username or service name."];
        return NO;
    }
    
    [self deletePasswordForService:serviceName username:accountName];
    
    if (!password)
        return YES;
    
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrAccount, accountName);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    CFDictionaryAddValue(query, kSecValueData, [password dataUsingEncoding:NSUTF8StringEncoding]);
    OSStatus status = SecItemAdd(query, NULL);
    CFRelease(query);
    
    if (status != noErr) {
        if (error) *error = [NSError errorWithDomain:kPSKeychainErrorDomain code:status description:@"An unknown error occurred while storing the password."];
        return NO;
    }
    
    return YES;
}

@end