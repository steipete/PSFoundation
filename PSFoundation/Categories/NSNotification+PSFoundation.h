//
//  NSNotification+PSFoundation.h
//  PSFoundation
//
//  Created by Peter Steinberger on 04.11.09.
//  Licensed under MIT.  All rights reserved.
//

@interface NSNotificationCenter (PSFoundation)

- (void) postNotificationOnMainThread:(NSNotification *) notification;
- (void) postNotificationOnMainThread:(NSNotification *) notification waitUntilDone:(BOOL) wait;

- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object;
- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo;
- (void) postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait;

@end
