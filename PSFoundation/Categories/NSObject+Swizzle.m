//
//  NSObject+Swizzle.m
//  PSFoundation
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (PSSwizzling)

#define SetNSError(ERROR_VAR, FORMAT,...) if (ERROR_VAR) { \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,__func__,##__VA_ARGS__]; \
NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1	userInfo:userInfo]; \
}

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel error:(NSError**)error {
	Method origMethod = class_getInstanceMethod(self, origSel);
	if (!origMethod) {
		SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(origSel), NSStringFromClass([self class]));
		return NO;
	}
	
	Method altMethod = class_getInstanceMethod(self, altSel);
	if (!altMethod) {
		SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel), NSStringFromClass([self class]));
		return NO;
	}
	
	class_addMethod(self,
					origSel,
					class_getMethodImplementation(self, origSel),
					method_getTypeEncoding(origMethod));
	class_addMethod(self,
					altSel,
					class_getMethodImplementation(self, altSel),
					method_getTypeEncoding(altMethod));
	
	method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
	return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel error:(NSError **)error {
    return [object_getClass(self) swizzleMethod:origSel withMethod:altSel error:error];
}

+ (BOOL)swizzleMethod:(SEL)orig ofClass:(Class)c withSelector:(SEL)newSelector error:(NSError **)error {
    return [c swizzleMethod:orig withMethod:newSelector error:error];
}

@end
