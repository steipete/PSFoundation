//
//  NSSet+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

#import "NSObject+Utilities.h"

@interface NSMutableSet (PSFoundation)
- (void)addObjectIfNotNil:(id)anObject;
@end