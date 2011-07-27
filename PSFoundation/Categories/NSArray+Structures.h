//
//  NSArray+Structures.h
//  PSFoundation
//
//  Includes code by the following:
//   - Aleks Nesterow.  2010.  MIT.
//   - Pieter Omvlee.   2010.  Public domain.
//   - Erica Sadun.     2009.  Public domain.
//

@interface NSArray (PSArrayStructures)
@property (nonatomic, readonly, getter = firstObject) id first;
@property (nonatomic, readonly, getter = lastObject) id last;
@end

@interface NSMutableArray (PSArrayStructures)
- (void)enqueue:(id)object;
- (id)dequeue;

- (void)push:(id)object;
- (id)pull;
- (id)pop;

- (void)removeFirstObject;
@end
