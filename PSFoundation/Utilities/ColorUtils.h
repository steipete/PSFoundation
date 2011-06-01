//
//  ColorUtils.h
//

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \
green:((c>>16)&0xFF)/255.0 \
blue:((c>>8)&0xFF)/255.0 \
alpha:((c)&0xFF)/255.0];  

// usage:
//UIColor* c = HEXCOLOR(0xff00ffff);

static float* HexToFloats(int c)
{
  static float components[4];
  components[0] = ((c>>24)&0xFF)/255.0;
  components[1] = ((c>>16)&0xFF)/255.0;
  components[2] = ((c>> 8)&0xFF)/255.0;
  components[3] = ((c    )&0xFF)/255.0;
  return components;
}

// usage:
//CGContextSetStrokeColor(c, HexToFloats(0x808080ff));

@interface UIColor (UIColorUtils)
+ (UIColor*)navigationColorForTab:(int)tab;
+ (UIColor*)cellColorForTab:(int)tab;
+ (UIColor*)cellLabelColor;
+ (UIColor*)conversationBackground;
@end