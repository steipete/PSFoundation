//
//  NSArray+Linq.m
//  TouchCustoms
//
//  Created by Aleks Nesterow on 8/10/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screencustoms, LLC.
//	All rights reserved.
//

#import "NSArray+Linq.h"

@implementation NSArray (Linq)

+ (id)aggregate:(NSArray *)array usingBlock:(id (^)(id accumulator, id currentItem))block {

	id result = nil;
	
	NSEnumerator *enumerator = [array objectEnumerator];
	id firstObject = [enumerator nextObject];
	
	if (firstObject) {
	
		result = firstObject;
		
		id secondObject;
		
		while ((secondObject = [enumerator nextObject])) {
		
			result = block(result, secondObject);
		}
	}
	
	return result;
}

- (id)aggregateUsingBlock:(id (^)(id accumulator, id currentItem))block {
	
	return [NSArray aggregate:self usingBlock:block];
}

+ (NSArray *)select:(NSArray *)array usingBlock:(id (^)(id currentItem))block {
	
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
	
	for (id object in array) {
		
		[result addObject:block(object)];
	}
	
	return result;
}

- (NSArray *)selectUsingBlock:(id (^)(id currentItem))block {
	
	return [NSArray select:self usingBlock:block];
}

@end
