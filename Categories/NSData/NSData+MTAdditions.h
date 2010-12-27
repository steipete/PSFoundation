//
//  NSData+MTAdditions.h
//  PSFoundation
//
//  Created by Matthias Tretter on 27.12.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CLLocation;

@interface NSData (MTAdditions)

- (NSData *)dataWithEXIFUsingLocation:(CLLocation *)location;

@end
