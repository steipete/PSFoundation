//
//  NSSet+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

#import "NSSet+PSFoundation.h"

@implementation NSSet (PSFoundation)

- (BOOL)isEmpty {
    return (self.count == 0);
}

@end

@implementation NSMutableSet (PSFoundation)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject)
        [self addObject:anObject];
}

@end