//
//  MANotificationCenterAdditions.h
//  ZeroingWeakRef
//
//  Created by Michael Ash on 7/12/10.
//

#import <Foundation/Foundation.h>


@interface NSNotificationCenter (MAZeroingWeakRefAdditions)

- (void)addWeakObserver: (id)observer selector: (SEL)selector name: (NSString *)name object: (NSString *)object;

@end
