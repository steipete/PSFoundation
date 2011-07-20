//
//  SFHFKeychainUtils.m
//  PSFoundation
//
//  Includes code by the following:
//   - Buzz Andersen.   2008.  MIT.
//   - Jon Crosby.
//   - Mike Malone.
//   - Jonathan Wight.
//

#import "SFHFKeychainUtils.h"
#import <Security/Security.h>
#import "NSError+SCMethods.h"

static NSString *SFHFKeychainUtilsErrorDomain = @"SFHFKeychainUtilsErrorDomain";

@implementation SFHFKeychainUtils

+ (NSString *)getPasswordForUsername:(NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error {
    if (!username || !serviceName) {
        if (error)
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:-2000 description:@"Username or service name not given.  Cannot retrieve item."];
        return nil;
    }
    
    if (error)
        *error = nil;
    
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 4, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrAccount, username);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    CFDictionaryAddValue(query, kSecReturnAttributes, kCFBooleanTrue);
    
    CFTypeRef attributeResult = NULL, resultData = NULL;
        
    OSStatus status = SecItemCopyMatching(query, &attributeResult);
    
    if (status != noErr) {
        if (error && status != errSecItemNotFound) {
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:status description:@"An error occurred while retrieving the keychain item."];
        }
        CFRelease(query);
        return nil;
    }

    CFDictionaryAddValue(query, kSecReturnData, kCFBooleanTrue);
    
    status = SecItemCopyMatching(query, &resultData);
    
    CFRelease(query);
    
    if (status != noErr) {
        if (status == errSecItemNotFound) {
			// We found attributes for the item previously, but no password now, so return a special error.
			// Users of this API will probably want to detect this error and prompt the user to
			// re-enter their credentials.  When you attempt to store the re-entered credentials
			// using storeUsername:andPassword:forServiceName:updateExisting:error
			// the old, incorrect entry will be deleted and a new one with a properly encrypted
			// password will be added.
			if (error)
				*error = [NSError errorWithDomain: SFHFKeychainUtilsErrorDomain code: -1999 description:@"Password not stored or corrupted for given service."];
        } else {
			// Something else went wrong. Simply return the normal Keychain API error code.
            if (error)
                *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:status description:@"Unknown error in retrieving password data."];
        }
        CFRelease(resultData);
        return nil;
    }
    
    if (!resultData) {
		// There is an existing item, but we weren't able to get password data for it for some reason,
		// Possibly as a result of an item being incorrectly entered by the previous code.
		// Set the -1999 error so the code above us can prompt the user again.
        if (error)
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:-1999 description:@"Password data not retrievable for key.  Please try again."];
    } else {
        NSString *string = [[NSString alloc] initWithData:(NSData *)resultData encoding:NSUTF8StringEncoding];
        
        CFRelease(resultData);
        
        return [string autorelease];
    }
    
    return nil;
}

+ (BOOL)storeUsername:(NSString *)username andPassword:(NSString *)password forServiceName:(NSString *)serviceName updateExisting:(BOOL)updateExisting error:(NSError **)error {
    if (!username || !password || !serviceName) {
        if (error) {
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:-2000 description:@"Username or service name not given.  Cannot store item."];
        }
        return NO;
    }
    
    NSError *getError = nil;
    NSString *existingPassword = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:serviceName error:&getError];
    
    if ([getError code] == -1999) {
		// There is an existing entry without a password properly stored (possibly as a result of the previous incorrect version of this code.
		// Delete the existing item before moving on entering a correct one.
        
		getError = nil;
		
		[self deleteItemForUsername: username andServiceName: serviceName error: &getError];
        
		if ([getError code] != noErr) {
			if (error) {
				*error = getError;
			}
			return NO;
		}
    } else if ([getError code] != noErr) {
		if (error) {
			*error = getError;
		}
		return NO;
	}
    
    if (error) {
        *error = nil;
    }
    
    OSStatus status = noErr;
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    CFDictionaryAddValue(query, kSecAttrLabel, serviceName);
    CFDictionaryAddValue(query, kSecAttrAccount,username);
    
    if (existingPassword) {
		// We have an existing, properly entered item with a password.
		// Update the existing item.
        if (updateExisting && ![existingPassword isEqualToString:password]) {
            NSDictionary *update = [NSDictionary dictionaryWithObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(NSString *)kSecValueData];
            status = SecItemUpdate(query, (CFDictionaryRef)update);
        }
    } else {
		// No existing entry (or an existing, improperly entered, and therefore now
		// deleted, entry).  Create a new entry.
        CFDictionaryAddValue(query, kSecValueData, [password dataUsingEncoding:NSUTF8StringEncoding]);
        status = SecItemAdd(query, NULL);
    }
    
    CFRelease(query);
    
    if (status != noErr) {
        // Something went wrong with adding the new item. Return the Keychain error code.
        if (error)
            *error = [NSError errorWithDomain: SFHFKeychainUtilsErrorDomain code:status description:@"An unknown error occurred while storing the password."];
        return NO;
    }
    
    return YES;
}

+ (BOOL)deleteItemForUsername: (NSString *)username andServiceName:(NSString *)serviceName error:(NSError **)error {
    if (!username || !serviceName) {
        if (error) {
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:-2000 description:@"Username or service name not given.  Cannot delete item."];
        }
        return NO;
    }
    
    if (error) {
        *error = nil;
    }
    
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 4, NULL, NULL);
    CFDictionaryAddValue(query, kSecClass, kSecClassGenericPassword);
    CFDictionaryAddValue(query, kSecAttrAccount, username);
    CFDictionaryAddValue(query, kSecAttrService, serviceName);
    CFDictionaryAddValue(query, kSecReturnAttributes, kCFBooleanTrue);
    
    OSStatus status = SecItemDelete(query);
    
    CFRelease(query);
    
    if (status != noErr) {
        if (error)
            *error = [NSError errorWithDomain:SFHFKeychainUtilsErrorDomain code:status description:@"An unknown error occurred while deleting the password"];
        return NO;
    }
    
    return YES;
}


@end
