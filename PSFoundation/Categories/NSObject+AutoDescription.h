//
//  NSObject+AutoDescription.h
//  PSFoundation
//
//  Created by Peter Steinberger on 09.09.10.
//  Licensed under MIT.  All rights reserved.
//
//  References:
//   - http://stackoverflow.com/questions/2299841/objective-c-introspection-reflection
//

@interface NSObject (AutoDescription)

+ (NSString *) autoDescribe:(id)instance classType:(Class)classType;
+ (NSString *) autoDescribe:(id)instance;

@end
