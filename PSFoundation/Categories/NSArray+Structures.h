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
- (id)firstObject;
@end

@interface NSMutableArray (PSArrayStructures)
- (void)enqueue:(id)object;
- (id)dequeue;

- (NSMutableArray *)push:(id)object;
- (NSMutableArray *)pushObject:(id)object;
- (NSMutableArray *)pushObjects:(id)object, ...;

- (id) pull;
- (id) pullObject;

- (id) pop;
- (id) popObject;

- (void)removeFirstObject;
@end
