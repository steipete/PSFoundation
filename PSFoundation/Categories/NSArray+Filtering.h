//
//  NSArray+Filtering.h
//  PSFoundation
//
//  Includes code by the following:
//   - Erica Sadun.       2009.  Public domain.
//   - Peter Steinberger. 2009.  MIT.
//   - Matthias Tretter.  2010.  MIT.
//

@interface NSArray (PSArrayAlgebra)
- (id)uniqueMembers;
- (id)unionWithArray:(NSArray *)array;
- (id)intersectionWithArray:(NSArray *)array;
- (id)intersectionWithSet:(NSSet *)set;
- (id)complementWithArray:(NSArray *)anArray;
- (id)complementWithSet:(NSSet *)anSet;
@end

@interface NSArray (PSArrayResort)
- (id)arrayByReversing;
- (id)arrayByShuffling;
@property (readonly, getter=arrayByReversing) id reversed;
@property (readonly, getter=arrayByShuffling) id shuffled;
@end

@interface NSMutableArray (PSArrayResort)
- (void)reverse;
- (void)shuffle;
@property (readonly) id reversed;
@property (readonly) id shuffled;

@end

@interface NSArray (PSArraySorting)
- (id)objectUsingPredicate:(NSPredicate *)predicate;
- (id) arrayBySortingStrings;
@property (readonly, getter=arrayBySortingStrings) id sortedStrings;
@property (readonly) NSString *stringValue;
@end