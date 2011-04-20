//
//  NSFetchedResultsController+ActiveRecord.m
//  PSFoundation
//
//  Created by Peter Steinberger on 18.04.11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import "NSFetchedResultsController+ActiveRecord.h"

#if TARGET_OS_IPHONE
@implementation NSFetchedResultsController (ActiveRecord)

- (void)refetchWithPredicate:(NSPredicate *)newPredicate {
	if ([newPredicate isEqual:[self.fetchRequest predicate]])
		return;
    
	if (self.cacheName)
		[NSFetchedResultsController deleteCacheWithName:self.cacheName];
    
	[self.fetchRequest setPredicate:newPredicate];
	[self performFetch:nil];
}

- (NSArray *)objectsPassingPredicate:(NSPredicate *)predicate {
	return [self.fetchedObjects filteredArrayUsingPredicate:predicate];
}

- (BOOL)hasObjectsPassingPredicate:(NSPredicate *)predicate {
	return [[self objectsPassingPredicate:predicate] count] > 0;
}

- (BOOL)hasObjects {
	return [self count] > 0;
}

- (NSUInteger)count {
	return [self.fetchedObjects count];
}

@end
#endif