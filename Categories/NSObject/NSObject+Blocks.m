//
//  NSObject+Blocks.m
//  PSFoundation
//
//  Created by Peter Steinberger on 24.10.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import "NSObject+Blocks.h"


void RunAfterDelay(NSTimeInterval delay, BasicBlock block) {
  [[[block copy] autorelease] performSelector:@selector(ps_callBlock) withObject:nil afterDelay:delay];
}

@implementation NSObject (BlocksAdditions)

- (void)ps_callBlock {
  void (^block)(void) = (id)self;
  block();
}

@end
