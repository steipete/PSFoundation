//
//  UIImageView+PSLib.m
//
//  Created by Peter Steinberger on 16.01.10.
//

#import "UIImageView+PSLib.h"

@implementation UIImageView (PSLib)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
  return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]] autorelease]; 
}

@end
