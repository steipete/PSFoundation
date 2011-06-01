//
//  NSArray+Linq.h
//  PSFoundation
//
//  Created by Aleks Nesterow on 8/10/10.
//  Copyright © 2010 Screencustoms, LLC.
//

@interface NSArray (Linq)

+ (id)aggregate:(NSArray *)array usingBlock:(id (^)(id accumulator, id currentItem))block DEPRECATED_ATTRIBUTE;
- (id)aggregateUsingBlock:(id (^)(id accumulator, id currentItem))block DEPRECATED_ATTRIBUTE;

+ (NSArray *)select:(NSArray *)array usingBlock:(id (^)(id currentItem))block DEPRECATED_ATTRIBUTE;
- (NSArray *)selectUsingBlock:(id (^)(id currentItem))block DEPRECATED_ATTRIBUTE;

@end
