//
//  NSArray+Linq.h
//  TouchCustoms
//
//  Created by Aleks Nesterow on 8/10/10.
//	aleks.nesterow@gmail.com
//	
//  Copyright © 2010 Screencustoms, LLC.
//	All rights reserved.
//	
//	Purpose
//	Contains LINQ-like operators for arrays.
//

@interface NSArray (Linq)

+ (id)aggregate:(NSArray *)array usingBlock:(id (^)(id accumulator, id currentItem))block;
- (id)aggregateUsingBlock:(id (^)(id accumulator, id currentItem))block;

+ (NSArray *)select:(NSArray *)array usingBlock:(id (^)(id currentItem))block;
- (NSArray *)selectUsingBlock:(id (^)(id currentItem))block;

@end
