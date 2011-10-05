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

static char sectionCountKey;

@implementation UIViewController (MTAnimatedFetch)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSFetchedResultsController Animated Update
////////////////////////////////////////////////////////////////////////

- (void)handleController:(NSFetchedResultsController *)controller willChangeContentForTableView:(UITableView *)tableView {
    [self associateValue:$I(0) withKey:&sectionCountKey];
	[tableView beginUpdates];
}

- (void)handleController:(NSFetchedResultsController *)controller didChangeContentForTableView:(UITableView *)tableView {
	[tableView endUpdates];
}

- (void)handleController:(NSFetchedResultsController *)controller
		 didChangeObject:(id)anObject
			 atIndexPath:(NSIndexPath *)indexPath
		   forChangeType:(NSFetchedResultsChangeType)type
			newIndexPath:(NSIndexPath *)newIndexPath
			   tableView:(UITableView *)tableView {
    
    int sectionInsertCount =  [[self associatedValueForKey:&sectionCountKey] intValue];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            NSString *sectionKeyPath = [controller sectionNameKeyPath];
            if (sectionKeyPath == nil)
                break;
            NSManagedObject *changedObject = [controller objectAtIndexPath:indexPath];
            NSArray *keyParts = [sectionKeyPath componentsSeparatedByString:@"."];
            id currentKeyValue = [changedObject valueForKeyPath:sectionKeyPath];
            for (int i = 0; i < [keyParts count] - 1; i++) {
                NSString *onePart = [keyParts objectAtIndex:i];
                changedObject = [changedObject valueForKey:onePart];
            }
            sectionKeyPath = [keyParts lastObject];
            NSDictionary *committedValues = [changedObject committedValuesForKeys:nil];
            
            if ([[committedValues valueForKeyPath:sectionKeyPath] isEqual:currentKeyValue])
                break;
            
            NSUInteger tableSectionCount = [tableView numberOfSections];
            NSUInteger frcSectionCount = [[controller sections] count];
            if (tableSectionCount + sectionInsertCount != frcSectionCount) {
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
                if (newSectionLocation == -1)
                    break; // uh oh
                
                if (!((newSectionLocation == 0) && (tableSectionCount == 1) && ([tableView numberOfRowsInSection:0] == 0))) {
                    [tableView insertSections:[NSIndexSet indexSetWithIndex:newSectionLocation] withRowAnimation:UITableViewRowAnimationFade];
                    sectionInsertCount++;
                }
                
                NSUInteger indices[2] = {newSectionLocation, 0};
                newIndexPath = [[[NSIndexPath alloc] initWithIndexes:indices length:2] autorelease];
            }
        }
        case NSFetchedResultsChangeMove:
            if (newIndexPath != nil) {
                
                NSUInteger tableSectionCount = [tableView numberOfSections];
                NSUInteger frcSectionCount = [[controller sections] count];
                if (frcSectionCount != tableSectionCount + sectionInsertCount)  {
                    [tableView insertSections:[NSIndexSet indexSetWithIndex:[newIndexPath section]] withRowAnimation:UITableViewRowAnimationNone];
                    sectionInsertCount++;
                }
                
                
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:newIndexPath]
                                 withRowAnimation: UITableViewRowAnimationRight];
                
            }
            else {
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:[indexPath section]] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        default:
            break;
    }
    
    // update associated object sectionInsertCount
    [self associateValue:$I(sectionInsertCount) withKey:&sectionCountKey];
}

- (void)handleController:(NSFetchedResultsController *)controller
		didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
				 atIndex:(NSUInteger)sectionIndex
		   forChangeType:(NSFetchedResultsChangeType)type
			   tableView:(UITableView *)tableView {
    
    int sectionInsertCount = [[self associatedValueForKey:&sectionCountKey] intValue];
    
	switch(type) {
        case NSFetchedResultsChangeInsert:
            if (!((sectionIndex == 0) && ([tableView numberOfSections] == 1))) {
                [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                sectionInsertCount++;
            }
            
            break;
        case NSFetchedResultsChangeDelete:
            if (!((sectionIndex == 0) && ([tableView numberOfSections] == 1) )) {
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                sectionInsertCount--;
            }
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate: 
            break;
        default:
            break;
    }
    
    // update associated object sectionInsertCount
    [self associateValue:$I(sectionInsertCount) withKey:&sectionCountKey];
}

@end
