//
//  NSObject+AutoDescription.h
//  Created by Peter Steinberger on 09.09.10.
//

// thanks to Kendall Helmstetter Geln
// http://stackoverflow.com/questions/2299841/objective-c-introspection-reflection
@interface NSObject (AutoDescription)

+ (NSString *) autoDescribe:(id)instance classType:(Class)classType;
+ (NSString *) autoDescribe:(id)instance;

@end
