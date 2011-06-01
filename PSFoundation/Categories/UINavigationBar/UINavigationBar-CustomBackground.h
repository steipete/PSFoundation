//
//  UINavigationBar-CustomBackground.h
//  PSFoundation
//
//  Created by Peter Steinberger on 05.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface UINavigationBar (CustomBackground)

- (void)drawRectCustomBackground:(CGRect)rect;

@end

 /* Method Swizzling /

// Get our drawRectCustomBackground method
Method drawRectCustomBackground = class_getInstanceMethod([UINavigationBar class], @selector(drawRectCustomBackground:));

// Get the original drawRect method
Method drawRect = class_getInstanceMethod([UINavigationBar class], @selector(drawRect:));

// Swap the methods, drawRect now becomes drawRectCustomBackground and vice-versa
method_exchangeImplementations(drawRect, drawRectCustomBackground);

/ End Method Swizzling */
