//
//  DTCustomColoredAccessory.h
//  MW
//
//  Created by Oliver Drobnik on 2/10/12.
//  Copyright (c) 2012 Cocoanetics. All rights reserved.

#import <Foundation/Foundation.h>


typedef enum
{
    DTCustomColoredAccessoryTypeRight = 0,
    DTCustomColoredAccessoryTypeUp,
    DTCustomColoredAccessoryTypeDown
} DTCustomColoredAccessoryType;

@interface DTCustomColoredAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;

    DTCustomColoredAccessoryType _type;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

@property (nonatomic, assign)  DTCustomColoredAccessoryType type;

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;
+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color type:(DTCustomColoredAccessoryType)type;

@end
