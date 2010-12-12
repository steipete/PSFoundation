//
//  NSManagedObjectContext+FetchedObjectFromURI.h
//  PSFoundation
//
//  Created by Peter Steinberger on 27.11.10.
//  Copyright 2010 Peter Steinberger. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FetchedObjectFromURI)

- (NSManagedObject *)objectWithURI:(NSURL *)uri;

@end
