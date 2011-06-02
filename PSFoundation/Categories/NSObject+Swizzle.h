//
//  NSObject+Swizzle.h
//  PSFoundation
//
//  Created by Peter Steinberger on 08.01.10.
//  Licensed under MIT. All rights reserved.
//

#import "JRSwizzle.h"

@interface NSObject (PSSwizzling)

// all just aliases.
+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector;
+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel error:(NSError**)error;
+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)newSel error:(NSError**)error;

@end
