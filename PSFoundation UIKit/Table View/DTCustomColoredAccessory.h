//
//  DTCustomColoredAccessory.h
//  PSFoundation
//
//  Created by Matthias Tretter on 09.03.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  References:
//   - http://www.cocoanetics.com/2011/03/expandingcollapsing-tableview-sections/
//

typedef enum {
    DTCustomColoredAccessoryTypeRight = 0,
    DTCustomColoredAccessoryTypeUp,
    DTCustomColoredAccessoryTypeDown
} DTCustomColoredAccessoryType;

@interface DTCustomColoredAccessory : UIControl

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;
@property (nonatomic, assign)  DTCustomColoredAccessoryType type;

+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color;
+ (DTCustomColoredAccessory *)accessoryWithColor:(UIColor *)color type:(DTCustomColoredAccessoryType)type;

@end
