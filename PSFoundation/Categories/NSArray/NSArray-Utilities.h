/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

@interface NSArray (StringExtensions)
- (NSArray *) arrayBySortingStrings;
@property (readonly, getter=arrayBySortingStrings) NSArray *sortedStrings;
@property (readonly) NSString *stringValue;
@end

@interface NSArray (UtilityExtensions)
- (NSArray *)uniqueMembers;
- (NSArray *)unionWithArray:(NSArray *)array;
- (NSArray *)intersectionWithArray:(NSArray *)array;
- (NSArray *)intersectionWithSet:(NSSet *)set;
- (NSArray *)complementWithArray:(NSArray *)anArray;
- (NSArray *)complementWithSet:(NSSet *)anSet;
@end

@interface NSMutableArray (UtilityExtensions)

// Converts a set into an array; actually returns a
// mutable array, if that's relevant to you.
+ (NSMutableArray*) arrayWithSet:(NSSet*)set;

- (NSMutableArray *) removeFirstObject;
- (NSMutableArray *) reverse;
- (NSMutableArray *) scramble;
@property (readonly, getter=reverse) NSMutableArray *reversed;
@end

@interface NSMutableArray (StackAndQueueExtensions)
- (NSMutableArray *)pushObject:(id)object;
- (NSMutableArray *)pushObjects:(id)object,...;
- (id) popObject;
- (id) pullObject;

// Synonyms for traditional use
- (NSMutableArray *)push:(id)object;
- (id) pop;
- (id) pull;
@end

@interface NSArray (NSArray_365Cocoa)
- (id)firstObject;
@end


@interface NSArray (PSLib)
- (id)objectUsingPredicate:(NSPredicate *)predicate;

/*
 * Checks to see if the array is empty
 */
@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

@end
