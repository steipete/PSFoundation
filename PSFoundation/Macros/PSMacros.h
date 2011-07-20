//
//  PSMacros.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.
//   - Dirk Holtwick.
//   - Peter Steinberger. 2010. MIT.
//
//  References:
//   - http://www.dribin.org/dave/blog/archives/2008/09/22/convert_to_nsstring/
//

#include "PSMacros+Compatibility.h"
#include "PSMacros+Collections.h"

// compiler help
#define PS_INVALID(t)  [t invalidate]; t = nil
#define PS_VERIFIED_CLASS(c) ((c *) NSClassFromString(@"" # c))

// file management
#define NSDocumentsFolder() [NSFileManager documentsFolder]
#define PSDocumentsFolder() [NSFileManager documentsFolder]
#define NSLibraryFolder() [NSFileManager libraryFolder]
#define PSLibraryFolder() [NSFileManager libraryFolder]
#define NSBundleFolder() [NSFileManager bundleFolder]
#define PSBundleFolder() [NSFileManager bundleFolder]
#define PSGetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]


#define PSDegreesToRadian(x) (x * 0.017453293)
#define PSRadianToDegrees(x) (x * 57.295779513)

// Time Macros
#define PSTimeIntervalMilliseconds(x) (NSTimeInterval)(x / 1000.)
#define PSTimeIntervalSeconds(x) (NSTimeInterval)x
#define PSTimeIntervalMinutes(x) (NSTimeInterval)(x * 60.)
#define PSTimeIntervalHours(x) (NSTimeInterval)(x * 3600.)
#define PSTimeIntervalDays(x) (NSTimeInterval)(x * 3600. * 24.)

// Short hand NSLocalizedString
#define _(s) NSLocalizedString(s,s)
#define __(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]

// wrap to have non-retaining self pointers in blocks: safeSelf(dispatch_async(myQ, ^{[self doSomething];});
// use with care! can lead to crashes if self suddelny vanishes...
#define safeSelf(...) do {              \
__typeof__(self) __x = self;            \
__block __typeof__(self) self = __x;    \
__VA_ARGS__;                            \
} while (0)

// http://www.cimgf.com/2010/05/02/my-current-prefix-pch-file/
// use like PSAssert(anAsset != nil, @"Asset cannot be nil");
#define PSAssertM(condition, message) do { if(condition) { DDLogWarn(@"asserted with %@", message); assert(condition && message); }} while(0)
#define PSAssert(condition) do { if(condition) { DDLogWarn(@"asserted!");  assert(condition); }} while(0)
#define PSAssertReturnNil(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return nil; }} while (0)
#define PSAssertReturnNO(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return NO; }} while (0)
#define PSAssertReturn(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return; }} while (0)

// block asserts for non-debug builds ("the ugly tree")
#ifndef DEBUG
  // block classic assert()
  #ifndef NDEBUG
    #define NDEBUG
  #endif

  #ifndef NS_BLOCK_ASSERTIONS
    #define NS_BLOCK_ASSERTIONS
    #undef NSCAssert
    #define NSCAssert(condition, desc, ...) do { } while(0)
  #endif
#endif

// performance measurement
// #define PERF 1
#if PERF
#  define TSTART { NSTimeInterval __tStart = CFAbsoluteTimeGetCurrent();
#  define TSTOP NSLog(@"%s: %f secs", __PRETTY_FUNCTION__, CFAbsoluteTimeGetCurrent() - __tStart); }
#  define TSTOPLOG(fmt, ...) NSLog((@"%s\n\n    %.8f secs: " fmt @"\n\n"), __PRETTY_FUNCTION__, (CFAbsoluteTimeGetCurrent() - __tStart), ##__VA_ARGS__); }
#else
#  define TSTART
#  define TSTOP
#  define TSTOPLOG
#endif

// app shortcuts
#define XNavigationController   ((XRESPONDS(XAppDelegate, navigationController)) ? [[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)] : nil)
#define UIApp                   [UIApplication sharedApplication]
#define XAppDelegate            [UIApp delegate]
#define tsPushAnimated(vc)      [[[UIApp delegate] performSelector:@selector(navigationController)] pushViewController:vc animated:YES]
#define isIPad()                [[UIDevice currentDevice] isTablet]

// defines
#define XAPPVERSION() [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// filepaths
#define XFILPATH4DOCUMENT(_value) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_value]
#define XFILEPATH4BUNDLE(_value) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_value]
#define XURL4FILEPATH(_value) [NSURL fileURLWithPath:_value]
#define XURL4DOCUMENT(_value) [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_value]]
#define XURL4BUNDLE(_value) [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_value]]

// array sorting & fetching
#define XSORTED(arr,by,asc) [arr sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:by ascending:asc] autorelease]]]
#define XSORT(arr,by,asc) [arr sortUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:by ascending:asc] autorelease]]];
#define XRX(v) ([v isKindOfClass:[NSPredicate class]] ? v : [NSPredicate predicateWithFormat:@"SELF MATCHES %@", v])

// value shortcuts
#define xfloat(val)     [NSNumber numberWithFloat:(val)]
#define xint(val)       [NSNumber numberWithInt:(val)]
#define xbool(val)      [NSNumber numberWithBool:(val)]
#define xstr(...)       [NSString stringWithFormat:__VA_ARGS__]
#define xnull           [NSNull null]
#define xfalse          [NSNumber numberWithBool:NO]
#define xtrue           [NSNumber numberWithBool:YES]

#define XMCOPY(_obj)    [[_obj mutableCopy] autorelease]
#define XCOPY(_obj)     [[_obj copy] autorelease]

// sorting
#define XLT(a,b) ([a compare:b] == NSOrderedAscending)
#define XGT(a,b) ([a compare:b] == NSOrderedDescending)
#define XEQ(a,b) ([a compare:b] == NSOrderedSame)

// notification center
#define XNC             [NSNotificationCenter defaultCenter]
#define XNCADD(n,sel)   [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:n object:nil];
#define XNCREMOVE       [[NSNotificationCenter defaultCenter] removeObserver:self];
#define XNCPOST(name)   [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];

// selector apply
#define XRESPONDS(target, sel)          ([(id)target respondsToSelector:@selector(sel)])
#define XAPPLY(target, sel)             if (XRESPONDS(target, sel)) { [(id)target performSelector:@selector(sel)]; }
#define XAPPLY1(target, sel, obj)       if (XRESPONDS(target, sel)) { [(id)target performSelector:@selector(sel:) withObject:obj]; }
#define XAPPLYSEL(target, sel)          if (XRESPONDS(target, sel)) { [(id)target performSelector:sel]; }
#define XAPPLYSEL1(target, sel, obj)    if(XRESPONDS(target, sel)) { [(id)target performSelector:sel withObject:obj]; }

#define XDATA2UTF8STRING(data)  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]
#define XUTF8STRING2DATA(s)     [s dataUsingEncoding:NSUTF8StringEncoding]

// user defaults
#define XDEL_OBJECT(k)      [[NSUserDefaults standardUserDefaults] removeObjectForKey:k]
#define XGET_OBJECT(v)      [[NSUserDefaults standardUserDefaults] objectForKey:v]
#define XSET_OBJECT(k,v)    [[NSUserDefaults standardUserDefaults] setObject:v forKey:k]
#define XGET_STRING(v)      [[NSUserDefaults standardUserDefaults] stringForKey:v]
#define XSET_STRING(k,v)    [[NSUserDefaults standardUserDefaults] setObject:v forKey:k]
#define XGET_FLOAT(v)       [[NSUserDefaults standardUserDefaults] floatForKey:v]
#define XSET_FLOAT(k,v)     [[NSUserDefaults standardUserDefaults] setFloat:v forKey:k]
#define XGET_BOOL(v)        [[NSUserDefaults standardUserDefaults] boolForKey:v]
#define XSET_BOOL(k,v)      [[NSUserDefaults standardUserDefaults] setBool:v forKey:k]
#define XGET_INT(v)         [[NSUserDefaults standardUserDefaults] integerForKey:v]
#define XSET_INT(k,v)       [[NSUserDefaults standardUserDefaults] setInteger:v forKey:k]
#define XSYNC()             [[NSUserDefaults standardUserDefaults] synchronize]

//	The following macro is for specifying property (ivar) names to KVC or KVO methods.
//	These methods generally take strings, but strings don't get checked for typos
//	by the compiler. If you write PROPERTY(fremen) instead of PROPERTY(frame),
//	the compiler will immediately complain that it doesn't know the selector
//	'fremen', and thus point out the typo. For this to work, you need to make
//	sure the warning -Wunknown-selector is on.
//
//	The code that checks here is (theoretically) slower than just using a string
//	literal, so what we do is we only do the checking in debug builds. In
//	release builds, we use the identifier-stringification-operator "#" to turn
//	the given property name into an ObjC string literal.

#if DEBUG
#define PROPERTY(propName)	NSStringFromSelector(@selector(propName))
#else
#define PROPERTY(propName)	@#propName
#endif

//	The following use the same syntax as the ones in GNUstep. Just cuz that's
//	the closest we have to a standard for stuff like this.
//
//	Create a pool around some code by doing:
//		CREATE_AUTORELEASE_POOL(myPool);
//			// Use the pool.
//		DESTROY(myPool);
//
//	ASSIGN() is a neat macro to use inside mutators, DESTROY() is a shorthand
//	that lets you release an object and clear its variable in one go.
//
//	The do/while(0) stuff is just there so the macro behaves just like any other
//	function call, as far as if/else etc. are concerned.

#define CREATE_AUTORELEASE_POOL(pool)		NSAutoreleasePool*	(pool) = [[NSAutoreleasePool alloc] init]

#define ASSIGN(targ,newval)					do {\
NSObject* __UKHELPERMACRO_OLDTARG = (NSObject*)(targ);\
(targ) = [(newval) retain];\
[__UKHELPERMACRO_OLDTARG release];\
} while(0)

#define DESTROY(targ)						do {\
NSObject* __UKHELPERMACRO_OLDTARG = (NSObject*)(targ);\
(targ) = nil;\
[__UKHELPERMACRO_OLDTARG release];\
} while(0)

#define PS_NOT_IMPLEMENTED DDLogError(@"Not yet implemented: %@", _cmd);

// swapper

#define ps_swap(a,b) {  \
int c = (a);         \
(a) = (b);           \
(b) = c;             \
}

#define ps_swapf(a,b) { \
float c = (a);       \
(a) = (b);           \
(b) = c;             \
}
