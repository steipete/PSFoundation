//
//  NSObject+AssociatedObjects.h
//
//  Created by Andy Matuschak on 8/27/09.
//  Public domain because I love you.
// http://blog.andymatuschak.org/post/173646741/your-new-friends-obj-c-associated-objects
// https://github.com/andymatuschak/NSObject-AssociatedObjects

// pro-tip: use _cmd as key, selectors are unique and constant (per function)

@interface NSObject (AMAssociatedObjects)
- (void)associateValue:(id)value withKey:(void *)key; // Strong reference
- (void)weaklyAssociateValue:(id)value withKey:(void *)key;
- (id)associatedValueForKey:(void *)key;
@end
