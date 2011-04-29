//
//  UIView+WhenTappedBlocks.h
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#if NS_BLOCKS_AVAILABLE

#import <Foundation/Foundation.h>
#import "JMWhenTappedBlockKeeper.h"

@interface UIView (WhenTappedBlocks)

- (void) whenTapped:(WhenTappedBlock)block;
- (void) whenTouchedDown:(WhenTouchedDownBlock)block;
- (void) whenTouchedUp:(WhenTouchedUpBlock)block;

@end

#endif