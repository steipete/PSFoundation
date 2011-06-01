//
//  ColorUtils.m
//

#import "ColorUtils.h"

static UIColor *gNavigationBarColors[5];
static UIColor *gUnreadCellColors[5];

@implementation UIColor (UIColorUtils)

+ (UIColor*)navigationColorForTab:(int)tab
{
    return gNavigationBarColors[tab];
}

+ (UIColor*)cellColorForTab:(int)tab
{
    return gUnreadCellColors[tab];
}

+ (UIColor*)cellLabelColor
{
    return [UIColor colorWithRed:0.195 green:0.309 blue:0.520 alpha:1.0];
}

+ (UIColor*)conversationBackground
{
    return [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
}
@end
