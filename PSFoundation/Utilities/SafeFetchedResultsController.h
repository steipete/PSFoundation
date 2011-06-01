@protocol SafeFetchedResultsControllerDelegate;

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface SafeFetchedResultsController : NSFetchedResultsController <NSFetchedResultsControllerDelegate>
{
	id <SafeFetchedResultsControllerDelegate> safeDelegate;

	NSMutableArray *insertedSections;
	NSMutableArray *deletedSections;

	NSMutableArray *insertedObjects;
	NSMutableArray *deletedObjects;
	NSMutableArray *updatedObjects;
	NSMutableArray *movedObjects;
}

@property (nonatomic, assign) id <SafeFetchedResultsControllerDelegate> safeDelegate;

@end

@protocol SafeFetchedResultsControllerDelegate <NSFetchedResultsControllerDelegate, NSObject>
@optional

- (void)controllerDidMakeUnsafeChanges:(NSFetchedResultsController *)controller;

@end
