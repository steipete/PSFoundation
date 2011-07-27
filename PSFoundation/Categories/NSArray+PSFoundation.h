//
//  NSArray+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//   - Aleks Nesterow.  2010.  MIT.
//   - Pieter Omvlee.   2010.  Public domain.
//   - Erica Sadun.     2009.  Public domain.
//

#import "NSObject+Utilities.h"

@interface NSArray (PSFoundation)

+ (id)arrayWithSet:(NSSet*)set;
- (id)objectOrNilAtIndex:(NSUInteger)index;

@property (readonly, getter = firstObject) id first;
@property (readonly, getter = lastObject) id last;

@end