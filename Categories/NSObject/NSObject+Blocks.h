//
//  NSObject+Blocks.h
//  PSFoundation
//
//  Created by Peter Steinberger on 24.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

// some credits go to http://www.mikeash.com/pyblog/friday-qa-2009-08-14-practical-blocks.html
typedef void (^BasicBlock)(void);

void RunAfterDelay(NSTimeInterval delay, BasicBlock block);

@interface NSObject (BlocksAdditions)

- (void)ps_callBlock;

@end
