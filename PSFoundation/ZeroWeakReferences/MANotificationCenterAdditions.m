//
//  MANotificationCenterAdditions.m
//  ZeroingWeakRef
//
//  Created by Michael Ash on 7/12/10.
//

#import "MANotificationCenterAdditions.h"

#import "MAZeroingWeakRef.h"


@implementation NSNotificationCenter (MAZeroingWeakRefAdditions)

- (void)addWeakObserver: (id)observer selector: (SEL)selector name: (NSString *)name object: (NSString *)object
{
    [self addObserver: observer selector: selector name: name object: object];
    
    MAZeroingWeakRef *ref = [[MAZeroingWeakRef alloc] initWithTarget: observer];
    [ref setCleanupBlock: ^(id target) {
        [self removeObserver: target name: name object: object];
        [ref autorelease];
    }];
}

@end
