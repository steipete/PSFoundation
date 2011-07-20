//
//  UITableView+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Shaun Harrison.  2008.  MIT.
//

@interface UITableView (PSFoundation)

/*
 * Returns an array with A-Z and # to be used as section titles
 */
+ (NSArray *)alphaNumericTitles;

/*
 * Returns an array with the Search icon, A-Z and # to be used as section titles
 */
+ (NSArray *)alphaNumericTitlesWithSearch:(BOOL)search;


@end
