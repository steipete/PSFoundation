//
//  SynthesizeSingleton.h
//  PSFoundation
//
//  Includes code by the following:
//   - Matt Gallagher.  See below.
//   - Ching-Lan Huang.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#if __has_feature(objc_arc)

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *sharedInstance = nil; \
\
+ (classname *)sharedInstance { \
static dispatch_once_t pred; \
if (sharedInstance) return sharedInstance; \
dispatch_once(&pred, ^{ sharedInstance = [[super alloc] init]; }); \
return sharedInstance; \
} \
\
+ (classname *)shared##classname { \
return [self sharedInstance]; \
} \
\
+ (id)alloc { \
return [self sharedInstance]; \
}

#else

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *sharedInstance = nil; \
\
+ (classname *)sharedInstance { \
static dispatch_once_t pred; \
if (sharedInstance) return sharedInstance; \
dispatch_once(&pred, ^{ sharedInstance = [[super allocWithZone:NULL] init]; }); \
return sharedInstance; \
} \
\
+ (classname *)shared##classname { \
return [self sharedInstance]; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [[self sharedInstance] retain]; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
} \
\
- (id)retain { \
return self; \
} \
\
- (NSUInteger)retainCount { \
return NSUIntegerMax; \
} \
\
- (oneway void)release { \
} \
\
- (id)autorelease { \
return self; \
}

#endif