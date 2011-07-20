//
//  UIImageView+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 16.01.10.
//  Licensed under MIT.  All rights reserved.
//

#import "UIImageView+PSFoundation.h"

@implementation UIImageView (PSFoundation)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]] autorelease];
}

@end
