//
//  UIView+Animation.h
//  PSFoundation
//
//  Created by Matthias Tretter on 22.02.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
// Originally found at:
// http://kwigbo.tumblr.com/post/3448069097/simplify-uiview-animation-with-categories

#import <Foundation/Foundation.h>


@interface UIView (Animation)

// Animate removing a view from its parent
- (void)removeWithTransition:(UIViewAnimationTransition)transition duration:(float)duration;

// Animate adding a subview
- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition duration:(float)duration;

// Animate the changing of a views frame
- (void)setFrame:(CGRect)frame duration:(float)duration;

// Animate changing the alpha of a view
- (void)setAlpha:(float)alpha duration:(float)duration;

@end
