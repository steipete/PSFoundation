//
//  UIView+Hierarchy.h
//
//  Created by Marin Todorov on 26/02/2010.
//  for http://www.touch-code-magazine.com
//

#import <Foundation/Foundation.h>

@interface UIView (Hierarchy)

-(int)getSubviewIndex;

-(void)bringToFront;
-(void)sendToBack;

-(void)bringOneLevelUp;
-(void)sendOneLevelDown;

-(BOOL)isInFront;
-(BOOL)isAtBack;

-(void)swapDepthsWithView:(UIView*)swapView;

@end