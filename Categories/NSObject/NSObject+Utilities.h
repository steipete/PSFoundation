//
//  NSObject+Utilities.h
//  PSFoundation
//
//  Created by Peter Steinberger on 12.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

@interface NSObject (Utilities)

+ (id) make;

- (void) performSelector: (SEL) selector afterDelay: (NSTimeInterval) delay;

@end
