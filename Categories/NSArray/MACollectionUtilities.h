//
//  MACollectionUtilities.h
//  MACollectionUtilities
//
// MMACollectionUtilities is distributed under a BSD license, as listed below.
// Copyright (c) 2010, Michael Ash
// All rights reserved.
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// Neither the name of Michael Ash nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// https://github.com/mikeash/MACollectionUtilities
#import <Foundation/Foundation.h>


#define ARRAY(...) ([NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])
#define SET(...) ([NSSet setWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)])

// this is key/object order, not object/key order, thus all the fuss
#define DICT(...) MADictionaryWithKeysAndObjects(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)

#define MAP(collection, ...) EACH_WRAPPER([collection ma_map: ^id (id obj) { return (__VA_ARGS__); }])
#define SELECT(collection, ...) EACH_WRAPPER([collection ma_select: ^BOOL (id obj) { return (__VA_ARGS__) != 0; }])
#define REJECT(collection, ...) EACH_WRAPPER([collection ma_select: ^BOOL (id obj) { return (__VA_ARGS__) == 0; }])
#define MATCH(collection, ...) EACH_WRAPPER([collection ma_match: ^BOOL (id obj) { return (__VA_ARGS__) != 0; }])
#define REDUCE(collection, initial, ...) EACH_WRAPPER([collection ma_reduce: (initial) block: ^id (id a, id b) { return (__VA_ARGS__); }])

#define EACH(array) MAEachHelper(array, &MA_eachTable)

@interface NSArray (MACollectionUtilities)

- (NSArray *)ma_map: (id (^)(id obj))block;
- (NSArray *)ma_select: (BOOL (^)(id obj))block;
- (id)ma_match: (BOOL (^)(id obj))block;
- (id)ma_reduce: (id)initial block: (id (^)(id a, id b))block;

@end

@interface NSSet (MACollectionUtilities)

- (NSSet *)ma_map: (id (^)(id obj))block;
- (NSSet *)ma_select: (BOOL (^)(id obj))block;
- (id)ma_match: (BOOL (^)(id obj))block;

@end


// ===========================================================================
// internal utility whatnot that needs to be externally visible for the macros
#define IDARRAY(...) ((id[]){ __VA_ARGS__ })
#define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))
#define EACH_WRAPPER(...) (^{ __block CFMutableDictionaryRef MA_eachTable = nil; \
        (void)MA_eachTable; \
        __typeof__(__VA_ARGS__) MA_retval = __VA_ARGS__; \
        if(MA_eachTable) \
            CFRelease(MA_eachTable); \
        return MA_retval; \
    }())

static inline NSDictionary *MADictionaryWithKeysAndObjects(id const *keysAndObjs, NSUInteger count)
{
    id keys[count];
    id objs[count];
    for(NSUInteger i = 0; i < count; i++)
    {
        keys[i] = keysAndObjs[i * 2];
        objs[i] = keysAndObjs[i * 2 + 1];
    }

    return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
}

static inline id MAEachHelper(NSArray *array, CFMutableDictionaryRef *eachTablePtr)
{
    if(!*eachTablePtr)
    {
        CFDictionaryKeyCallBacks keycb = {
            0,
            kCFTypeDictionaryKeyCallBacks.retain,
            kCFTypeDictionaryKeyCallBacks.release,
            kCFTypeDictionaryKeyCallBacks.copyDescription,
            NULL,
            NULL
        };
        *eachTablePtr = CFDictionaryCreateMutable(NULL, 0, &keycb, &kCFTypeDictionaryValueCallBacks);
    }

    NSEnumerator *enumerator = (id)CFDictionaryGetValue(*eachTablePtr, array);
    if(!enumerator)
    {
        enumerator = [array objectEnumerator];
        CFDictionarySetValue(*eachTablePtr, array, enumerator);
    }
    return [enumerator nextObject];
}
