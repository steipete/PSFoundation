//
//  NSObject+Swizzle.h
//  PSFoundation
//
//  Created by Jonathan Rentzsch on 31 May 2009.
//  Licensed under MIT. All rights reserved.
//

@interface NSObject (PSSwizzling)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel error:(NSError**)error;
+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)newSel error:(NSError**)error;
+ (BOOL)swizzleMethod:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector error:(NSError**)error;

@end
