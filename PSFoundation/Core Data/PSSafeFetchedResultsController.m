//
//  PSSafeFetchedResultsController.m
//  PSFoundation (CoreData)
//

#import "PSSafeFetchedResultsController.h"
#import <CoreData/CoreData.h>
#import "NSObject+Utilities.h"

@interface PSSafeFetchedResultsController()
@property (nonatomic, retain) NSMutableArray *insertedSections;
@property (nonatomic, retain) NSMutableArray *deletedSections;
@property (nonatomic, retain) NSMutableArray *insertedObjects;
@property (nonatomic, retain) NSMutableArray *deletedObjects;
@property (nonatomic, retain) NSMutableArray *updatedObjects;
@property (nonatomic, retain) NSMutableArray *movedObjects;
@end

@interface SafeSectionChange : NSObject

@property (nonatomic, retain) id <NSFetchedResultsSectionInfo> sectionInfo;
@property (nonatomic, assign) NSUInteger sectionIndex;
@property (nonatomic, assign) NSFetchedResultsChangeType changeType;

+ (id)changeWithSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo index:(NSUInteger)sectionIndex changeType:(NSFetchedResultsChangeType)changeType;
@end

@interface SafeObjectChange : NSObject

@property (nonatomic, retain) id object;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) NSFetchedResultsChangeType changeType;
@property (nonatomic, retain) NSIndexPath *toIndexPath;

+ (id)changeWithObject:(id)object indexPath:(NSIndexPath *)indexPath changeType:(NSFetchedResultsChangeType)changeType newIndexPath:(NSIndexPath *)newIndexPath;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation PSSafeFetchedResultsController

@synthesize safeDelegate, insertedSections, deletedSections, insertedObjects, deletedObjects, updatedObjects, movedObjects;

- (id)initWithFetchRequest:(NSFetchRequest *)fetchRequest managedObjectContext:(NSManagedObjectContext *)context sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)name {
	if ((self = [super initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:sectionNameKeyPath cacheName:name])) {
		self.delegate = self;
        self.insertedSections = [NSMutableArray array];
		self.deletedSections  = [NSMutableArray array];
		self.insertedObjects  = [NSMutableArray array];
		self.deletedObjects   = [NSMutableArray array];
		self.updatedObjects   = [NSMutableArray array];
		self.movedObjects     = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc {
    self.insertedSections = nil;
    self.deletedSections = nil;
    self.insertedObjects = nil;
    self.deletedObjects = nil;
    self.updatedObjects = nil;
    self.movedObjects = nil;
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Logic
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Checks to see if there are unsafe changes in the current change set.
**/
- (BOOL)hasUnsafeChanges {
	return (insertedSections.count + deletedSections.count > 1);
}

/**
 * Helper method for hasPossibleUpdateBug.
 * Please see that method for documenation.
**/
- (void)addIndexPath:(NSIndexPath *)indexPath toDictionary:(NSMutableDictionary *)dictionary
{
	NSNumber *sectionNumber = [NSNumber numberWithUnsignedInteger:indexPath.section];

	NSMutableIndexSet *indexSet = [dictionary objectForKey:sectionNumber];
	if (!indexSet) {
		indexSet = [NSMutableIndexSet indexSet];

		[dictionary setObject:indexSet forKey:sectionNumber];
	}

#ifdef DEBUG
    DDLogInfo(@"Adding index(%lu) to section(%@)", indexPath.row, sectionNumber);
#endif

	[indexSet addIndex:indexPath.row];
}

/**
 * Checks to see if there are any moved objects that might have been improperly tagged as updated objects.
**/
- (void)fixUpdateBugs {
	if (updatedObjects.empty) return;

	// In order to test if a move could have been improperly flagged as an update,
	// we have to test to see if there are any insertions, deletions or moves that could
	// have possibly affected the update.

    __block NSUInteger numInsertedSections = insertedSections.count;
	__block NSUInteger numDeletedSections  = deletedSections.count;

	__block NSUInteger numInsertedObjects = insertedObjects.count + movedObjects.count;
	__block NSUInteger numDeletedObjects  = deletedObjects.count + movedObjects.count;

	__block NSUInteger numChangedSections = numInsertedSections + numDeletedSections;
	__block NSUInteger numChangedObjects = numInsertedObjects + numDeletedObjects;

	if (numChangedSections > 0 || numChangedObjects > 0) {
		// First we create index sets for the inserted and deleted sections.
		// This will allow us to see if a section change could have created a problem.

		NSMutableIndexSet *sectionInsertSet = [NSMutableIndexSet indexSet];
		NSMutableIndexSet *sectionDeleteSet = [NSMutableIndexSet indexSet];
        
        [insertedSections each:^(id change) {
            [sectionInsertSet addIndex:[change sectionIndex]];
        }];
            
        [deletedSections each:^(id change) {
            [sectionDeleteSet addIndex:[change sectionIndex]];
        }];

		// Next we create dictionaries of index sets for the object changes.
		//
		// The keys for the dictionary will be each indexPath.section from the object changes.
		// And the corresponding values are an NSIndexSet with all the indexPath.row values from that section.
		//
		// For example:
		//
		// Insertions: [2,0], [1,2]
		// Deletions : [0,4]
		// Moves     : [2,3] -> [1,5]
		//
		// InsertDict = {
		//   1 = {2,5},
		//   2 = {0}
		// }
		//
		// DeleteDict = {
		//   0 = {4},
		//   2 = {3}
		// }
		//
		// From these dictionaries we can quickly test to see if a move could
		// have been improperly flagged as an update.
		//
		// Update at [4,2] -> Not affected
		// Update at [0,1] -> Not affected
		// Update at [2,1] -> Possibly affected (1)
		// Update at [0,5] -> Possibly affected (2)
		// Update at [2,4] -> Possibly affected (3)
		//
		// How could they have been affected?
		//
		// 1) The "updated" object was originally at [2,1],
		//    and then its sort value changed, prompting it to move to [2,0].
		//    But at the same time an object is inserted at [2,0].
		//    The final index path is still [2,1] so NSFRC reports it as an update.
		//
		// 2) The "updated" object was originally at [0,5],
		//    and then its sort value changed, prompting it to move to [0,6].
		//    But at the same time, an object is deleted at [0,4].
		//    The final index path is still [0,5] so NSFRC reports it as an update.
		//
		// 3) The move is essentially the same as a deletion at [2,3].
		//    So this is similar to the example above.

		NSMutableDictionary *objectInsertDict = [NSMutableDictionary dictionaryWithCapacity:numInsertedObjects];
		NSMutableDictionary *objectDeleteDict = [NSMutableDictionary dictionaryWithCapacity:numDeletedObjects];
        
        [insertedObjects each:^(id change) {
            [self addIndexPath:[change toIndexPath] toDictionary:objectInsertDict];
        }];
        
        [deletedObjects each:^(id change) {
            [self addIndexPath:[change indexPath] toDictionary:objectDeleteDict];
        }];
        
        [movedObjects each:^(id change) {
			[self addIndexPath:[change indexPath] toDictionary:objectDeleteDict];
			[self addIndexPath:[change toIndexPath] toDictionary:objectInsertDict];
        }];
        
        [updatedObjects each:^(id change) {
#ifdef DEBUG
            DDLogInfo(@"Processing %@", change);
#endif
            
			if (![change toIndexPath]) {
				NSIndexPath *indexPath = [change indexPath];
                
				// Determine if affected by section changes
                
				NSRange range = NSMakeRange(0 /*location*/, indexPath.section + 1 /*length*/);
                
				numInsertedSections = [sectionInsertSet countOfIndexesInRange:range];
				numDeletedSections  = [sectionDeleteSet countOfIndexesInRange:range];
                
				// Determine if affected by object changes
                
				NSNumber *sectionNumber = [NSNumber numberWithUnsignedInteger:indexPath.section];
                
				range = NSMakeRange(0 /*location*/, indexPath.row + 1 /*length*/);
                
				numInsertedObjects = 0;
				numDeletedObjects = 0;
                
				NSIndexSet *insertsInSameSection = [objectInsertDict objectForKey:sectionNumber];
				if (insertsInSameSection)
					numInsertedObjects = [insertsInSameSection countOfIndexesInRange:range];
                
				NSIndexSet *deletesInSameSection = [objectDeleteDict objectForKey:sectionNumber];
				if (deletesInSameSection)
					numDeletedObjects = [deletesInSameSection countOfIndexesInRange:range];

#ifdef DEBUG
                DDLogInfo(@"numInsertedSections: %lu", numInsertedSections);
                DDLogInfo(@"numDeletedSections: %lu", numDeletedSections);
                DDLogInfo(@"numInsertedObjects: %lu", numInsertedObjects);
                DDLogInfo(@"numDeletedObjects: %lu", numDeletedObjects);
#endif

				// If the update might actually be a move,
				// then alter the objectChange to reflect the possibility.
				numChangedSections = numInsertedSections + numDeletedSections;
				numChangedObjects = numInsertedObjects + numDeletedObjects;
                
				if (numChangedSections > 0 || numChangedObjects > 0)
                    [change setToIndexPath:[change indexPath]];
			}
        }];
	}

	// One more example of a move causing a problem:
	//
	// [0,0] "Catherine"
	// [0,1] "King"
	// [0,2] "Tuttle"
	//
	// Now imagine that we make the following changes:
	//
	// "King" -> "Ben King"
	// "Tuttle" -> "Alex Tuttle"
	//
	// We should end up with this
	//
	// [0,0] "Alex Tuttle" <- Moved from [0,2]
	// [0,1] "Ben King"    <- Moved from [0,1]
	// [0,2] "Catherine"
	//
	// However, because index path for "King" remained the same,
	// the NSFRC incorrectly reports it as an update.
	//
	// The end result is similar to the example given at the very top of this file.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Processing
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)notifyDelegateOfSectionChange:(SafeSectionChange *)sectionChange {
	SEL selector = @selector(controller:didChangeSection:atIndex:forChangeType:);

	if ([safeDelegate respondsToSelector:selector])
		[safeDelegate controller:self
		        didChangeSection:sectionChange.sectionInfo
		                 atIndex:sectionChange.sectionIndex
		           forChangeType:sectionChange.changeType];
}

- (void)notifyDelegateOfObjectChange:(SafeObjectChange *)objectChange {
	SEL selector = @selector(controller:didChangeObject:atIndexPath:forChangeType:toIndexPath:);

	if ([safeDelegate respondsToSelector:selector])
		[safeDelegate controller:self didChangeObject:objectChange.object atIndexPath:objectChange.indexPath forChangeType:objectChange.changeType newIndexPath:objectChange.toIndexPath];
}

- (void)processSectionChanges {
    [insertedSections each:^(id sectionChange) {
        [self notifyDelegateOfSectionChange:sectionChange];
    }];
    
    [deletedSections each:^(id sectionChange) {
        [self notifyDelegateOfSectionChange:sectionChange];
    }];
}


- (void)processObjectChanges {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    // Check for and possibly fix the InsertSection or DeleteSection bug
    [self fixUpdateBugs];
       
    // Process object changes
    for (SafeObjectChange *objectChange in insertedObjects)
        [self notifyDelegateOfObjectChange:objectChange];
       
    for (SafeObjectChange *objectChange in deletedObjects)
        [self notifyDelegateOfObjectChange:objectChange];
       
    for (SafeObjectChange *objectChange in updatedObjects)
        [self notifyDelegateOfObjectChange:objectChange];
       
    for (SafeObjectChange *objectChange in movedObjects)
        [self notifyDelegateOfObjectChange:objectChange];
    
    [pool release];
}

- (void)processChanges {
#ifdef DEBUG
		DDLogInfo(@"PSSafeFetchedResultsController: processChanges");
        
        [insertedSections each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
        
        [deletedSections each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
         
        [insertedObjects each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
        
        [deletedObjects each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
        
        [updatedObjects each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
        
        [movedObjects each:^(id change) {
            DDLogInfo(@"%@", change);
        }];
#endif

	if ([self hasUnsafeChanges]) {
		if ([safeDelegate respondsToSelector:@selector(controllerDidMakeUnsafeChanges:)])
			[safeDelegate controllerDidMakeUnsafeChanges:self];
	} else {
		if ([safeDelegate respondsToSelector:@selector(controllerWillChangeContent:)])
			[safeDelegate controllerWillChangeContent:self];

		[self processSectionChanges];
		[self processObjectChanges];

		if ([safeDelegate respondsToSelector:@selector(controllerDidChangeContent:)])
			[safeDelegate controllerDidChangeContent:self];
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSFetchedResultsControllerDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// Nothing to do yet
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)changeType {
	NSMutableArray *sectionChanges = nil;
	switch (changeType) {
		case NSFetchedResultsChangeInsert : sectionChanges = insertedSections; break;
		case NSFetchedResultsChangeDelete : sectionChanges = deletedSections;  break;
	}
	[sectionChanges addObject:[SafeSectionChange changeWithSectionInfo:sectionInfo index:sectionIndex changeType:changeType]];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)changeType newIndexPath:(NSIndexPath *)newIndexPath {
	// Queue changes for processing later

	NSMutableArray *objectChanges = nil;
	switch (changeType) {
		case NSFetchedResultsChangeInsert : objectChanges = insertedObjects; break;
		case NSFetchedResultsChangeDelete : objectChanges = deletedObjects;  break;
		case NSFetchedResultsChangeUpdate : objectChanges = updatedObjects;  break;
		case NSFetchedResultsChangeMove   : objectChanges = movedObjects;    break;
	}
	[objectChanges addObject:[SafeObjectChange changeWithObject:anObject indexPath:indexPath changeType:changeType newIndexPath:newIndexPath]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self processChanges];

	[insertedSections removeAllObjects];
	[deletedSections  removeAllObjects];

	[insertedObjects  removeAllObjects];
	[deletedObjects   removeAllObjects];
	[updatedObjects   removeAllObjects];
	[movedObjects     removeAllObjects];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation SafeSectionChange

@synthesize sectionInfo, sectionIndex, changeType;

+ (id)changeWithSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo index:(NSUInteger)sectionIndex changeType:(NSFetchedResultsChangeType)changeType {
    SafeSectionChange *instance = [super make];
    instance.sectionInfo = sectionInfo;
    instance.sectionIndex = sectionIndex;
    instance.changeType = changeType;
    return instance;
}

- (NSString *)changeTypeString {
	switch (changeType) {
		case NSFetchedResultsChangeInsert : return @"Insert";
		case NSFetchedResultsChangeDelete : return @"Delete";
	}
	return nil;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<SafeSectionChange changeType(%@) index(%lu)>", [self changeTypeString], sectionIndex];
}

- (void)dealloc {
    self.sectionInfo = nil;
    [super dealloc];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation SafeObjectChange

@synthesize object, indexPath, changeType, toIndexPath;

+ (id)changeWithObject:(id)object indexPath:(NSIndexPath *)indexPath changeType:(NSFetchedResultsChangeType)changeType newIndexPath:(NSIndexPath *)newIndexPath {
    SafeObjectChange *instance = [super make];
    instance.object = object;
    instance.indexPath = indexPath;
    instance.changeType = changeType;
    instance.toIndexPath = newIndexPath;
    return instance;
}

- (NSString *)changeTypeString {
	switch (changeType) {
		case NSFetchedResultsChangeInsert : return @"Insert";
		case NSFetchedResultsChangeDelete : return @"Delete";
		case NSFetchedResultsChangeMove   : return @"Move";
		case NSFetchedResultsChangeUpdate : return @"Update";
	}

	return nil;
}

- (NSString *)stringFromIndexPath:(NSIndexPath *)ip {
	if (!ip) return @"nil";

	return [NSString stringWithFormat:@"[%lu,%lu]", ip.section, ip.row];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<SafeObjectChange changeType(%@) indexPath(%@) newIndexPath(%@)>",
			[self changeTypeString],
			[self stringFromIndexPath:indexPath],
			[self stringFromIndexPath:toIndexPath]];
}

- (void)dealloc {
    self.object = nil;
    self.indexPath = nil;
    self.toIndexPath = nil;
    [super dealloc];
}

@end
