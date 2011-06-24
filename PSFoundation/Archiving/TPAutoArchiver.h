//
//  TPAutoArchiver.h
//  TPAutoArchiver
//
//  Created by Joshua Pennington on 6/27/09.
//  Licensed under MIT.
//

@interface TPAutoArchiver : NSObject
+ (void)archiveObject:(id)anObject withCoder:(NSCoder *)aCoder;
+ (void)unarchiveObject:(id)anObject withCoder:(NSCoder *)aCoder;
@end

// Informal protocol for objects that wish to control which keys are serialized.
@interface NSObject (TPAutoArchiverKeyControl)
+ (NSArray *)autoArchiverKeysToExclude;
+ (NSArray *)autoArchiverKeysToAdd;
@end
