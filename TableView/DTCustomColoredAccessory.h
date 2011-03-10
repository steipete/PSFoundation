//
//  DTCustomColoredAccessory.h
//  MW
//
//  Created by Matthias Tretter on 09.03.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Found on cocoanetics.com

#import <Foundation/Foundation.h>


@interface DTCustomColoredAccessory : UIControl {
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;

@end
