//
//  MACollectionUtilities.h
//  PSFoundation
//
//  Created by Michael Ash on 10/11/2010.
//  Distributed under a BSD license.  All rights reserved.
//  https://github.com/mikeash/MACollectionUtilities
//

@interface NSArray (MACollectionUtilities)

- (NSArray *)ma_map: (id (^)(id obj))block DEPRECATED_ATTRIBUTE;
- (NSArray *)ma_select: (BOOL (^)(id obj))block DEPRECATED_ATTRIBUTE;
- (id)ma_match: (BOOL (^)(id obj))block DEPRECATED_ATTRIBUTE;
- (id)ma_reduce: (id)initial block: (id (^)(id a, id b))block DEPRECATED_ATTRIBUTE;

@end

@interface NSSet (MACollectionUtilities)

- (NSSet *)ma_map: (id (^)(id obj))block DEPRECATED_ATTRIBUTE;
- (NSSet *)ma_select: (BOOL (^)(id obj))block DEPRECATED_ATTRIBUTE;
- (id)ma_match: (BOOL (^)(id obj))block DEPRECATED_ATTRIBUTE;

@end

