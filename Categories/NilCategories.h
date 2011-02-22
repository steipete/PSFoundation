//
//  NilCategories.h
//
//  Based on Vincent Gable
//

@interface NSString (NilCategories)
- (NSURL*) convertToURL;
- (NSURL*) convertToURLRelativeToURL:(NSURL*)baseURL;
@end

@interface NSArray (NilCategories)
- (id)objectOrNilAtIndex:(NSUInteger)index;
@end

@interface NSMutableArray (NilCategories)
- (void)addObjectIfNotNil:(id)anObject;
- (BOOL)addObjectsFromArrayIfNotNil:(NSArray *)otherArray;
@end

@interface NSMutableDictionary (NilCategories)
- (void) setObjectToObjectForKey:(id)key inDictionary:(NSDictionary*)otherDictionary;
- (void)setObject:(id)anObject forKeyIfNotNil:(id)aKey;
@end;

@interface NSMutableSet (NilCategories)
- (void)addObjectIfNotNil:(id)anObject;
@end
