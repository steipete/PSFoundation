//
//  NSObject+Utilities.m
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.      2009.
//   - Peter Steinberger.  2010.  MIT.
//   - Zachary Waldowski.  2011.  MIT.
//

#import "NSObject+Utilities.h"

@implementation NSObject (PSFoundation)

+ (id) make {
    return [[[[self class] alloc] init] autorelease];
}

- (BOOL)isEmpty {
    return self == nil ||
    ([self isEqual:[NSNull null]]) ||
    ([self respondsToSelector:@selector(length)] && [(NSData *)self length] == 0) ||
    ([self respondsToSelector:@selector(count)]  && [(NSArray *)self count] == 0);
}

- (void) performSelector: (SEL) selector afterDelay: (NSTimeInterval) delay {
	[self performSelector:selector withObject:nil afterDelay: delay];
}


@end
