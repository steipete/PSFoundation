//
//  NSDictionary+PSFoundation.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

#import "NSObject+Utilities.h"

@interface NSDictionary (PSFoundation)
- (BOOL)containsObjectForKey:(id)key;
@end

@interface NSMutableDictionary (PSFoundation)
- (void)setObjectToObjectForKey:(id)key inDictionary:(NSDictionary *)otherDictionary;
- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey;
@end