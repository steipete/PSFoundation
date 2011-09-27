// Part of FoundationKit http://foundationk.it

#import <Foundation/Foundation.h>

/**
 This category adds safe methods to NSObject for removing an observer. If you remove an observer, that was already
 removed or got never added you get an NSRangeException. These methods wrap the calls to removeObserver in a try-catch
 block and only log this exception
 */

@interface NSObject (FKObserver)

/**
 Safely calls removeObserver:forKeyPath: on NSObject
 
 @param observer The observer to remove
 @param keyPath The keyPath the observer observes
 */
- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/**
 Safely calls removeObserver:forKeyPath:context: on NSObject
 
 @param observer The observer to remove
 @param keyPath The keyPath the observer observes
 @param context The context of the observation
 */
- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;

@end
