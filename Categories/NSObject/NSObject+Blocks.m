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

+ (id) performBlock:(void(^)())aBlock afterDelay:(NSTimeInterval)seconds {
  if (!aBlock) return nil;

  __block BOOL cancelled = NO;

  void (^aWrappingBlock)(BOOL) = ^(BOOL cancel){
    if (cancel) {
      cancelled = YES;
      return;
    }
    if (!cancelled) aBlock();
  };

  aWrappingBlock = [[aWrappingBlock copy] autorelease]; // move to the heap

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0e9 * seconds)),
                 dispatch_get_main_queue(),
                 ^{
                   aWrappingBlock(NO);
                 });

  return aWrappingBlock;
}

+ (void) cancelPreviousPerformBlock:(id)aWrappingBlockHandle {
  if (!aWrappingBlockHandle) return;
  void (^aWrappingBlock)(BOOL) = (void(^)(BOOL))aWrappingBlockHandle;
  aWrappingBlock(YES);
}

@end
