//
//  Copyright 2010 holtwick.it. All rights reserved.
//

// TODO: Currently this Logger crashes on iOS devices!

#if TARGET_IPHONE_SIMULATOR

#import <objc/runtime.h> 
#import <objc/message.h>
#include <execinfo.h>
#include <stdio.h>

NSString *HOGetMethodCallWithArguments(id *__selfPtr, SEL __cmd, char *fallback);  

#define HOLogPing \
        NSLog(@"%@", HOGetMethodCallWithArguments(&self, _cmd, (char *)__PRETTY_FUNCTION__));

#else

// Fallback solution for iOS devices

#define HOLogPing \
        NSLog(@"%s", __PRETTY_FUNCTION__);

#endif