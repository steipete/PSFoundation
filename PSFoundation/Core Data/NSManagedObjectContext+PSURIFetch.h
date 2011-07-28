//
//  NSManagedObjectContext+FetchedObjectFromURI.h
//  PSFoundation (CoreData)
//

#import <CoreData/CoreData.h>

/** Safe fetching of an NSManagedObject by its URI.

 Includes code by the following:
 
 - [Peter Steinberger](https://github.com/steipete) - 2010. MIT.
 - [Matt Gallagher](http://cocoawithlove.com/2008/08/safely-fetching-nsmanagedobject-by-uri.html) - 2008. Public domain.

 @warning Documentation on this class/category is incomplete.
 
 */
@interface NSManagedObjectContext (PSURIFetch)

- (NSManagedObject *)objectWithURI:(NSURL *)uri;

@end
