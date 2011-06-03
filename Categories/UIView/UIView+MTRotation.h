//
//  UIView+MTRotation.h
//  TVThek
//
//  Created by Matthias Tretter on 27.05.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (MTRotation)

/** property to specify a frame for portrait orientation */
@property (nonatomic, assign) CGRect portraitFrame;
/** property to specify a frame for landscape orientation */
@property (nonatomic, assign) CGRect landscapeFrame;
/** specifies whether portrait and landscape frames are defined for this view */
@property (nonatomic, readonly) BOOL hasPortraitAndLandscapeFrames;


/**
 * Animates the frame to the frame for the given interface orientation
 *
 * @param toInterfaceOrientation the interface orientation that specifies the frame used
 * @param duration the duration of the animation
 */
- (void)animateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

/**
 * Sets the frame of the UIView to the frame for the given interface orientation
 *
 * @param interfaceOrientation the interface orientation that specifies the frame used
 */
- (void)setFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/**
 * Animates all subviews that support rotation (hasPortraitAndLandscapeFrames == YES) (not recursive!) 
 * to the frame for the given interface orientation
 *
 * @param interfaceOrientation the interface orientation that specifies the frame used
 * @param duration the duration of the animation
 */
- (void)animateSubviewsToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end
