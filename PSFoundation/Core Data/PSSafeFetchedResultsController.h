//
//  PSSafeFetchedResultsController.h
//  PSFoundation (CoreData)
//
//  Created by Robbie Hansen on 2/15/10.
//

@protocol PSSafeFetchedResultsControllerDelegate;

#import <CoreData/CoreData.h>

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
#import <UIKit/UIKit.h>

/** Fixes a major flaw in the NSFetchedResultsController class.
 
 Normally, NSFetchedResultsController will incorrectly flag moved objects
 as simple updates in the face or inserts or deletions. Depending on the
 context of the changes, this can cause a crash or simply cause the
 improper table cell to be updated.

 The problem occurs when an inserted/deleted section/object causes a moved
 object to end up at the same index path as where it was before.
 
 PSSafeFetchedResultsController fixes these bugs by taking control of all
 updates and making sure the proper calls are fired.

 Includes code by the following:
 
 - [Robbie Hansen](http://deusty.blogspot.com/2010/02/more-bugs-in-nsfetchedresultscontroller.html) - 2008. Public domain.
 - [Peter Steinberger](https://github.com/steipete) - 2010. MIT.
 - [Matthias Tretter](https://github.com/myell0w) - 2011. MIT.
 
 */
@interface PSSafeFetchedResultsController : NSFetchedResultsController <NSFetchedResultsControllerDelegate>

/* Users of PSSafeFetchedResultsController would use this property **instead of
 the normal delegate property** to recieve all NSFetchedResultsControllerDelegate
 methods as well as the single PSSafeFetchedResultsControllerDelegate method.
 */
@property (nonatomic, assign) id <PSSafeFetchedResultsControllerDelegate> safeDelegate;
@end

@protocol PSSafeFetchedResultsControllerDelegate <NSFetchedResultsControllerDelegate, NSObject>
@optional
- (void)controllerDidMakeUnsafeChanges:(NSFetchedResultsController *)controller;
@end
#endif