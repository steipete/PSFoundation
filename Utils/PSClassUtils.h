//
//  PSClassUtils.h
//
//  Created by Peter Steinberger on 08.01.10.
//

//#import </usr/include/objc/objc-class.h>
#import <objc/runtime.h>

@interface PSClassUtils : NSObject {
}

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector;

@end
