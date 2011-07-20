//
//  UITableView+PSFoundation.m
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

#import "UITableView+PSFoundation.h"

@implementation UITableView (PSFoundation)

+ (NSArray *)alphaNumericTitles {
	return [self alphaNumericTitlesWithSearch:NO];
}

+ (NSArray *)alphaNumericTitlesWithSearch:(BOOL)search {
	if (search)
        return [NSArray arrayWithObjects: @"{search}",
				@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
				@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
				@"W", @"X", @"Y", @"Z", @"#", nil];
	else
		return [NSArray arrayWithObjects:
				@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", 
				@"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", 
				@"W", @"X", @"Y", @"Z", @"#", nil];
}

@end
