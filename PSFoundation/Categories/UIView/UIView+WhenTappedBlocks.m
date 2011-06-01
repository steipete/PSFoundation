//
//  UIView+WhenTappedBlocks.m
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#if NS_BLOCKS_AVAILABLE

#import "UIView+WhenTappedBlocks.h"
#import <objc/runtime.h>

@interface UIView (JMWhenTappedBlocks_Private)

- (void)runBlockForKey:(void *)blockKey;
- (void)setBlock:(JMWhenTappedBlock)block forKey:(void *)blockKey;

@end

@implementation UIView (JMWhenTappedBlocks)

static char kWhenTappedBlockKey;
static char kWhenTouchedDownBlockKey;
static char kWhenTouchedUpBlockKey;

- (void)runBlockForKey:(void *)blockKey {
    JMWhenTappedBlock block = objc_getAssociatedObject(self, blockKey);
    if (block) block();
}

- (void)setBlock:(JMWhenTappedBlock)block forKey:(void *)blockKey {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)whenTapped:(JMWhenTappedBlock)block {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapGesture;
    tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)] autorelease];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tapGesture];
    
    [self setBlock:block forKey:&kWhenTappedBlockKey];
}

- (void)whenTouchedDown:(JMWhenTappedBlock)block {
    [self setBlock:block forKey:&kWhenTouchedDownBlockKey];
}

- (void)whenTouchedUp:(JMWhenTappedBlock)block {
    [self setBlock:block forKey:&kWhenTouchedUpBlockKey];
}

- (void)viewWasTapped:(id)sender {
    [self runBlockForKey:&kWhenTappedBlockKey];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self runBlockForKey:&kWhenTouchedDownBlockKey];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self runBlockForKey:&kWhenTouchedUpBlockKey];
}

@end

#endif
