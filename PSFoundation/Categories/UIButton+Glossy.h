// Code is under 3-clause BSD
// http://www.mlsite.net/blog/?page_id=372

#import <UIKit/UIKit.h>

@interface UIButton (Glossy)

+ (UIButton *)glossyButtonWithTitle:(NSString *)title color:(UIColor *)color highlightColor:(UIColor *)highlightColor withArrow:(BOOL)arrow;
+ (UIButton *)glossyButtonWithTitle:(NSString *)title color:(UIColor *)color highlightColor:(UIColor *)highlightColor;

+ (void)setPathToRoundedRect:(CGRect)rect forInset:(NSUInteger)inset inContext:(CGContextRef)context;
+ (void)drawGlossyRect:(CGRect)rect withColor:(UIColor*)color inContext:(CGContextRef)context;
+ (void)drawGlossyRect:(CGRect)rect withColor:(UIColor*)color withArrow:(BOOL)arrow inContext:(CGContextRef)context;
- (void)setBackgroundToGlossyRectOfColor:(UIColor*)color withBorder:(BOOL)border withArrow:(BOOL)arrow forState:(UIControlState)state;
- (void)setBackgroundToGlossyRectOfColor:(UIColor*)color withBorder:(BOOL)border forState:(UIControlState)state;

@end

