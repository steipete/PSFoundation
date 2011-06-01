//
//  NSString+Truncation.h
//  PSFoundation
//
//  Created by Matthias Tretter on 22.02.11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Truncation)

- (NSString*)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;

@end
