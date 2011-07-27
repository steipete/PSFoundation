//
//  UIButton+Glossy.h
//  PSFoundation
//
//  Includes code by the following:
//   - Michael Heyeck. BSD.
//   - Erik Aigner.    Public domain.
//
//  References:
//   - http://www.mlsite.net/blog/?page_id=372
//

@interface UIButton (Glossy)

+ (UIButton *)glossyButtonWithTitle:(NSString *)title color:(UIColor *)color highlightColor:(UIColor *)highlightColor withArrow:(BOOL)arrow;
+ (UIButton *)glossyButtonWithTitle:(NSString *)title color:(UIColor *)color highlightColor:(UIColor *)highlightColor;

+ (void)setPathToRoundedRect:(CGRect)rect forInset:(NSUInteger)inset inContext:(CGContextRef)context;
+ (void)drawGlossyRect:(CGRect)rect withColor:(UIColor*)color inContext:(CGContextRef)context;
+ (void)drawGlossyRect:(CGRect)rect withColor:(UIColor*)color withArrow:(BOOL)arrow inContext:(CGContextRef)context;
- (void)setBackgroundToGlossyRectOfColor:(UIColor*)color withBorder:(BOOL)border withArrow:(BOOL)arrow forState:(UIControlState)state;
- (void)setBackgroundToGlossyRectOfColor:(UIColor*)color withBorder:(BOOL)border forState:(UIControlState)state;

+ (UIButton *)alertButtonWithFrame:(CGRect)buttonFrame;

@end

