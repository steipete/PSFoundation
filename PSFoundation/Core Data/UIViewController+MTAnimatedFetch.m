//
//  UIViewController+MTAnimatedFetch
//  PSFoundation
//
//  Created by Matthias Tretter on 09.04.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from Book More iPhone 3 Development
//  Chapter 2: The Anatomy of Core Data, Page 29ff

#import "UIViewController+MTAnimatedFetch.h"


@implementation UIViewController (MTAnimatedFetch)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSFetchedResultsController Animated Update
////////////////////////////////////////////////////////////////////////

- (void)handleControllerWillChangeContentForTableView:(UITableView *)tableView {
	[tableView beginUpdates];
}

- (void)handleControllerDidChangeContentForTableView:(UITableView *)tableView {
	[tableView endUpdates];
}

- (void)handleController:(NSFetchedResultsController *)controller
		 didChangeObject:(id)anObject
			 atIndexPath:(NSIndexPath *)indexPath
		   forChangeType:(NSFetchedResultsChangeType)type
			newIndexPath:(NSIndexPath *)newIndexPath
			   tableView:(UITableView *)tableView {

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate: {
            NSString *sectionKeyPath = [controller sectionNameKeyPath];
            if (sectionKeyPath == nil) {
                break;
            }

            NSManagedObject *changedObject = [controller objectAtIndexPath:indexPath];
            NSArray *keyParts = [sectionKeyPath componentsSeparatedByString:@"."];
            id currentKeyValue = [changedObject valueForKeyPath:sectionKeyPath];

            for (int i = 0; i < [keyParts count] - 1; i++) {
                NSString *onePart = [keyParts objectAtIndex:i];
                changedObject = [changedObject valueForKey:onePart];
            }

            sectionKeyPath = [keyParts lastObject];
            NSDictionary *committedValues = [changedObject committedValuesForKeys:nil];
            if ([[committedValues valueForKeyPath:sectionKeyPath] isEqual:currentKeyValue]) {
                break;
            }

            NSUInteger tableSectionCount = [tableView numberOfSections];
            NSUInteger frcSectionCount = [[controller sections] count];

            if (tableSectionCount != frcSectionCount) {
                // Need to insert a section
                NSArray *sections = controller.sections;
                NSInteger newSectionLocation = -1;

                for (id oneSection in sections) {
                    NSString *sectionName = [oneSection name];
                    if ([currentKeyValue isEqual:sectionName]) {
                        newSectionLocation = [sections indexOfObject:oneSection];
                        break;
                    }
                }

                if (newSectionLocation == -1) {
                    return; // uh oh
                }
                if (!((newSectionLocation == 0) && (tableSectionCount == 1) && ([tableView numberOfRowsInSection:0] == 0))) {
                    [tableView insertSections:[NSIndexSet indexSetWithIndex:newSectionLocation]
                                  withRowAnimation:UITableViewRowAnimationFade];
                }

                NSUInteger indices[2] = {newSectionLocation, 0};
                newIndexPath = [NSIndexPath indexPathWithIndexes:indices length:2];
            }
        }

        case NSFetchedResultsChangeMove:
            if (newIndexPath != nil) {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                      withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:newIndexPath]
                                      withRowAnimation: UITableViewRowAnimationRight];
            } else {
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                              withRowAnimation:UITableViewRowAnimationFade];
            }
            break;

        default:
            break;
    }
}

- (void)handleController:(NSFetchedResultsController *)controller
		didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
				 atIndex:(NSUInteger)sectionIndex
		   forChangeType:(NSFetchedResultsChangeType)type
			   tableView:(UITableView *)tableView {

	switch(type) {
		case NSFetchedResultsChangeInsert:
			if (!((sectionIndex == 0) && ([tableView numberOfSections] == 1) && ([tableView numberOfRowsInSection:0] == 0))) {
                [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						 withRowAnimation:UITableViewRowAnimationFade];
            }
            break;

        case NSFetchedResultsChangeDelete:
            if (!((sectionIndex == 0) && ([tableView numberOfSections] == 1) && ([tableView numberOfRowsInSection:0] == 0))) {
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						 withRowAnimation:UITableViewRowAnimationFade];
            }
            break;

        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        default:
            break;
    }
}

@end
