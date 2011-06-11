//
//  NilCategories.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.   2009.
//   - Shaun Harrison.  2009.  BSD.
//   - Wil Shipley.     2005.
//

@interface NSObject (NilCategories)
@property (nonatomic,readonly,getter=isEmpty) BOOL empty;
@end

@interface NSString (NilCategories)
- (NSURL *)convertToURL;
- (NSURL *)convertToURLRelativeToURL:(NSURL*)baseURL;
- (BOOL)isNotEmpty DEPRECATED_ATTRIBUTE;
- (BOOL)isEmptyOrWhitespace DEPRECATED_ATTRIBUTE;
- (BOOL)isWhitespaceAndNewlines DEPRECATED_ATTRIBUTE;
@end

@interface NSArray (NilCategories)
- (id)objectOrNilAtIndex:(NSUInteger)index;
@end

@interface NSMutableArray (NilCategories)
- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray;
@end

@interface NSDictionary (NilCategories)
- (BOOL)containsObjectForKey:(id)key;
@end

@interface NSMutableDictionary (NilCategories)
- (void)setObjectToObjectForKey:(id)key inDictionary:(NSDictionary*)otherDictionary;
- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey;
@end

@interface NSMutableSet (NilCategories)
- (void)addObjectIfNotNil:(id)anObject;
@end

@interface NSURL (NilCategories)
+ (NSURL *)URLWithStringOrNil:(NSString *)URLString;
@end
