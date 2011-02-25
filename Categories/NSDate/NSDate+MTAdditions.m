//
//  NSDate+MTAdditions.m
//  PSFoundation
//
//  Created by Matthias Tretter on 25.02.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "NSDate+MTAdditions.h"


@implementation NSDate (MTAdditions)

- (NSInteger)daysSinceDate:(NSDate *)date {
	NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];

	return timeInterval / 3600. / 24.;
}

@end
