//
//  NSData+MTAdditions.h
//  PSFoundation
//
//  Created by Matthias Tretter on 27.12.10.
//  Licensed under MIT. All rights reserved.
//

@class CLLocation;

@interface NSData (MTAdditions)

- (NSData *)dataWithEXIFUsingLocation:(CLLocation *)location;

@end
