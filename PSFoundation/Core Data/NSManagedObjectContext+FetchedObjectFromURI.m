//
//  NSManagedObjectContext+FetchedObjectFromURI.m
//  PSFoundation
//
//  Created by Peter Steinberger on 27.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//
//  http://cocoawithlove.com/2008/08/safely-fetching-nsmanagedobject-by-uri.html
//

#import "NSManagedObjectContext+FetchedObjectFromURI.h"
#import "NSObject+Utilities.h"

@implementation NSManagedObjectContext (FetchedObjectFromURI)

- (NSManagedObject *)objectWithURI:(NSURL *)uri {
    NSManagedObjectID *objectID = [[self persistentStoreCoordinator] managedObjectIDForURIRepresentation:uri];

    if (!objectID) {
    return nil;
    }

    NSManagedObject *objectForID = [self objectWithID:objectID];
    if (![objectForID isFault]) {
        return objectForID;
    }

    NSFetchRequest *request = [NSFetchRequest make];
    request.entity = objectID.entity;

    // Equivalent to
    // predicate = [NSPredicate predicateWithFormat:@"SELF = %@", objectForID];
    request.predicate = [NSComparisonPredicate
                         predicateWithLeftExpression:[NSExpression expressionForEvaluatedObject]
                         rightExpression:[NSExpression expressionForConstantValue:objectForID]
                         modifier:NSDirectPredicateModifier
                         type:NSEqualToPredicateOperatorType
                         options:0];

    NSArray *results = [self executeFetchRequest:request error:nil];
    if (!results.empty)
        return [results objectAtIndex:0];

    return nil;
}

@end
