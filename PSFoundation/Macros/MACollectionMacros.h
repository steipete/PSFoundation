//
//  MACollectionUtilities.h
//  PSFoundation
//
//  Created by Michael Ash on 10/11/2010.
//  Distributed under a BSD license.  All rights reserved.
//  https://github.com/mikeash/MACollectionUtilities
//

#import "NSArray+BlocksKit.h"
#import "NSSet+BlocksKit.h"
#import "NSDictionary+BlocksKit.h"

#define IDARRAY(...) ((id[]){ __VA_ARGS__ })
#define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))

#define ARRAY(...) ([NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])
#define SET(...) ([NSSet setWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])

// this is key/object order, not object/key order, thus all the fuss
#define DICT(...) MADictionaryWithKeysAndObjects(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)

#define MAP(collection, ...) EACH_WRAPPER([collection map: ^id (id obj) { return (__VA_ARGS__); }])
#define SELECT(collection, ...) EACH_WRAPPER([collection select: ^BOOL (id obj) { return (__VA_ARGS__); }])
#define REJECT(collection, ...) EACH_WRAPPER([collection reject: ^BOOL (id obj) { return (__VA_ARGS__); }])
#define MATCH(collection, ...) EACH_WRAPPER([collection match: ^BOOL (id obj) { return (__VA_ARGS__); }])
#define REDUCE(collection, initial, ...) EACH_WRAPPER([collection reduce: (initial) block: ^id (id a, id b) { return (__VA_ARGS__); }])

#define IDARRAY(...) ((id[]){ __VA_ARGS__ })
#define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))
#define EACH_WRAPPER(...) (^{ __block CFMutableDictionaryRef MA_eachTable = nil; \
(void)MA_eachTable; \
__typeof__(__VA_ARGS__) MA_retval = __VA_ARGS__; \
if(MA_eachTable) \
CFRelease(MA_eachTable); \
return MA_retval; \
}())

static inline NSDictionary *MADictionaryWithKeysAndObjects(id *keysAndObjs, NSUInteger count) {
    id keys[count];
    id objs[count];
    for(NSUInteger i = 0; i < count; i++)
    {
        keys[i] = keysAndObjs[i * 2];
        objs[i] = keysAndObjs[i * 2 + 1];
    }
    
    return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
}