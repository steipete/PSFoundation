//
//  NSArray+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

@interface NSArray (PSFoundation)

/*
 * Returns an array with A-Z and # to be used as section titles
 */
+ (id)arrayWithAlphaNumericTitles;

/*
 * Returns an array with the Search icon, A-Z and # to be used as section titles
 */
+ (id)arrayWithAlphaNumericTitlesWithSearch:(BOOL)search;

+ (id)arrayWithSet:(NSSet*)set;

@end

@interface NSMutableArray (PSFoundation)

-(void)moveObjectAtIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;
-(void)moveObject:(id)anObject toIndex:(NSUInteger)newIndex;

@end