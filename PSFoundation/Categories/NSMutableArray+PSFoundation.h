//
//  NSMutableArray+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//   - Aleks Nesterow.  2010.  MIT.
//   - Pieter Omvlee.   2010.  Public domain.
//   - Erica Sadun.     2009.  Public domain.
//

@interface NSMutableArray (PSFoundation)
- (void)removeFirstObject;

-(void)moveObjectAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;
-(void)moveObject:(id)anObject toIndex:(NSUInteger)newIndex;

- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray;

- (void)enqueue:(id)object;
- (id)dequeue;

- (void)push:(id)object;
- (id)pull;
- (id)pop;
@end