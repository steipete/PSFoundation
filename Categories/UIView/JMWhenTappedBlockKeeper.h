//
//  JMWhenTappedBlockKeeper.h
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//
// Found at: https://github.com/jakemarsh/JMWhenTapped

#if NS_BLOCKS_AVAILABLE

#import <Foundation/Foundation.h>

typedef void (^WhenTappedBlock)();
typedef void (^WhenTouchedDownBlock)();
typedef void (^WhenTouchedUpBlock)();

@interface JMWhenTappedBlockKeeper : NSObject <UIGestureRecognizerDelegate> {
    NSMutableDictionary *_whenTappedBlocks;
    NSMutableDictionary *_whenTouchedDownBlocks;
    NSMutableDictionary *_whenTouchedUpBlocks;
}

+ (JMWhenTappedBlockKeeper *) sharedInstance;

- (void) setBlock:(WhenTappedBlock)b forWhenViewIsTapped:(UIView *)v;
- (void) setBlock:(WhenTouchedDownBlock)b forWhenViewIsTouchedDown:(UIView *)v;
- (void) setBlock:(WhenTouchedUpBlock)b forWhenViewIsTouchedUp:(UIView *)v;

- (WhenTappedBlock) whenTappedBlockForView:(UIView *)v;
- (WhenTouchedDownBlock) whenTouchedDownBlockForView:(UIView *)v;
- (WhenTouchedUpBlock) whenTouchedUpBlockForView:(UIView *)v;

@end

#endif