#import "NSObject+FKObserver.h"

@implementation NSObject (FKObserver)

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    @try {
        [self removeObserver:observer forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        DDLogWarn(@"Tried to remove Observer '%@' for keyPath '%@' and got Exception: %@", observer, keyPath, exception);
    }
}

- (void)safeRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    @try {
        if ([self respondsToSelector:@selector(removeObserver:forKeyPath:context:)]) {
            [self removeObserver:observer forKeyPath:keyPath context:context];
        } else {
            [self removeObserver:observer forKeyPath:keyPath];
        }
    }
    @catch (NSException *exception) {
        DDLogWarn(@"Tried to remove Observer '%@' for keyPath '%@' in context and got Exception: %@", observer, keyPath, exception);
    }
}

@end
