//
//  NSFetchedResultsController+ActiveRecord.h
//  PSFoundation
//
//  Created by Peter Steinberger on 18.04.11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//  Original Code by Kyle Van Essen.
//

#import <CoreData/CoreData.h>

#if TARGET_OS_IPHONE
@interface NSFetchedResultsController (ActiveRecord)

- (void)refetchWithPredicate:(NSPredicate *)newPredicate;

- (NSArray *)objectsPassingPredicate:(NSPredicate *)predicate;
- (BOOL)hasObjectsPassingPredicate:(NSPredicate *)predicate;

@property(nonatomic, readonly) BOOL hasObjects;
@property(nonatomic, readonly) NSUInteger count;

@end
#endif