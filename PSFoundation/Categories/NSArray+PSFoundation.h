//
//  NSArray+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

#import "NSObject+Utilities.h"

@interface NSArray (PSFoundation)

+ (id)arrayWithSet:(NSSet*)set;
- (id)objectOrNilAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (PSFoundation)

-(void)moveObjectAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;
-(void)moveObject:(id)anObject toIndex:(NSUInteger)newIndex;

- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray;

@end