//
//  UIViewController+MTAnimatedFetch.h
//  PSFoundation
//
//  Created by Matthias Tretter on 09.04.11.
//  Copyright 2011 @myell0w. All rights reserved.
//
//  Taken from Book More iPhone 3 Development
//  Chapter 2: The Anatomy of Core Data, Page 29ff

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface UIViewController (MTAnimatedFetch)

- (void)handleController:(NSFetchedResultsController *)controller willChangeContentForTableView:(UITableView *)tableView;
- (void)handleController:(NSFetchedResultsController *)controller didChangeContentForTableView:(UITableView *)tableView;

- (void)handleController:(NSFetchedResultsController *)controller
		 didChangeObject:(id)anObject
			 atIndexPath:(NSIndexPath *)indexPath
		   forChangeType:(NSFetchedResultsChangeType)type
			newIndexPath:(NSIndexPath *)newIndexPath
			   tableView:(UITableView *)tableView;

- (void)handleController:(NSFetchedResultsController *)controller
		didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
				 atIndex:(NSUInteger)sectionIndex
		   forChangeType:(NSFetchedResultsChangeType)type
			   tableView:(UITableView *)tableView;

@end
