//
//  SafeFetchedResultsController.h
//  PSFoundation
//
//  Created by Robbie Hansen on 2/15/10.
//

@protocol SafeFetchedResultsControllerDelegate;

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface SafeFetchedResultsController : NSFetchedResultsController <NSFetchedResultsControllerDelegate> {
	NSMutableArray *insertedSections;
	NSMutableArray *deletedSections;

	NSMutableArray *insertedObjects;
	NSMutableArray *deletedObjects;
	NSMutableArray *updatedObjects;
	NSMutableArray *movedObjects;
}

@property (nonatomic, ps_weak) id <SafeFetchedResultsControllerDelegate> safeDelegate;

@end

@protocol SafeFetchedResultsControllerDelegate <NSFetchedResultsControllerDelegate, NSObject>
@optional
- (void)controllerDidMakeUnsafeChanges:(NSFetchedResultsController *)controller;
@end
