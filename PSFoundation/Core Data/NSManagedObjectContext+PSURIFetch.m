//
//  NSManagedObjectContext+PSURIFetch.m
//  PSFoundation (CoreData)
//

#import "NSManagedObjectContext+PSURIFetch.h"
#import "NSArray+PSFoundation.h"

@implementation NSManagedObjectContext (PSURIFetch)

- (NSManagedObject *)objectWithURI:(NSURL *)uri {
    NSManagedObjectID *objectID = [[self persistentStoreCoordinator] managedObjectIDForURIRepresentation:uri];
    if (!objectID)
        return nil;

    NSManagedObject *objectForID = [self objectWithID:objectID];
    if (!objectForID.isFault)
        return objectForID;

    NSFetchRequest *request = [NSFetchRequest make];
    request.entity = objectID.entity;

    // Equivalent to
    // predicate = [NSPredicate predicateWithFormat:@"SELF = %@", objectForID];
    request.predicate = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForEvaluatedObject]
                         rightExpression:[NSExpression expressionForConstantValue:objectForID]
                         modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:0];

    NSArray *results = [self executeFetchRequest:request error:nil];
    if (results.empty)
        return nil;
    
    return results.first;
}

@end
