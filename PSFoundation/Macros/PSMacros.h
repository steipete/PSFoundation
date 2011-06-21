//
//  PSMacros.h
//
//  Created by Peter Steinberger on 03.05.10.
//  Contains stuff from Dirk Holtwick - thanks for sharing!
//

#import "NilCategories.h"
#include "PSMacros+Collections.h"
#include "PSMacros+Geometry.h"

static inline BOOL IsEmpty(id thing) {
    if ([thing respondsToSelector:@selector(isEmpty)])
        return [thing isEmpty];
	return (!thing);
}

// compiler help
#define PSInvalidateTimer(t) { [t invalidate]; t = nil; }
#define INVALIDATE_TIMER(__TIMER) PSInvalidateTimer(__TIMER)

#define PSVerifiedClass(c) ((c *) NSClassFromString(@"" # c))
#define VERIFIED_CLASS(className) PSVerifiedClass(className)

// file management
#define NSDocumentsFolder() [NSFileManager documentsFolder]
#define PSDocumentsFolder() [NSFileManager documentsFolder]
#define NSLibraryFolder() [NSFileManager libraryFolder]
#define PSLibraryFolder() [NSFileManager libraryFolder]
#define NSBundleFolder() [NSFileManager bundleFolder]
#define PSBundleFolder() [NSFileManager bundleFolder]
#define PSGetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]

// color
#define SETTINGS_TEXT_COLOR	RGBCOLOR(57, 85, 135)
#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#endif
#define XHEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define XHEXCOLOR_ALPHA(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]
#define HEXCOLOR(c) XHEXCOLOR(c)
#define HexToFloats(c) XHEXCOLOR(c).CGColor

#define PSDegreesToRadian(x) (M_PI * (x) / 180.0)
#define PSRadianToDegrees(x) (M_PI * 180.0 / (x))

// Time Macros
#define PSTimeIntervalMilliseconds(x) (NSTimeInterval)(x / 1000.)
#define PSTimeIntervalSeconds(x) (NSTimeInterval)x
#define PSTimeIntervalMinutes(x) (NSTimeInterval)(x * 60.)
#define PSTimeIntervalHours(x) (NSTimeInterval)(x * 3600.)
#define PSTimeIntervalDays(x) (NSTimeInterval)(x * 3600. * 24.)

// Short hand NSLocalizedString
#define LocalizedString(s) NSLocalizedString(s,s)
#define _(s) NSLocalizedString(s,s)
#define LocalizedStringWithFormat(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]

// for function pass entering
#define DDLogFunction() DDLogInfo(@"-- logged --");

// http://www.alexcurylo.com/blog/2010/09/24/the-great-dealloc-debate/
#if DEBUG
#define MCRelease(x) do { [x release]; } while (0)
#else
#define MCRelease(x) [x release], x = nil
#endif
// always nil out for viewDidUnload!
#define MCReleaseNil(x) [x release], x = nil
#define MCReleaseViewNil(x) do { [x removeFromSuperview], [x release], x = nil; } while (0)


#if defined(TARGET_IPHONE_SIMULATOR) && defined(DEBUG)
#define PSSimulateMemoryWarning() CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#else
#define PSSimulateMemoryWarning()
#endif


// http://code.google.com/p/cocoalumberjack/wiki/XcodeTricks - compiles most log messages out of the release build, but not all!
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_INFO;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

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

  // block Log() macro
  #ifndef NO_LOG_MACROS
    #define NO_LOG_MACROS
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
#define XNavigationController [[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)]
#define XAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
// compatibility
#define MTApplicationDelegate XAppDelegate
#define UIApp [UIApplication sharedApplication].delegate // deprectated
#define tsPushAnimated(vc) [[[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)] pushViewController:vc animated:YES];

// defines
#define XAPPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

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

// value or nil
#define XINT(value) (value ? [NSNumber numberWithInt:value] : [NSNumber numberWithInt:0])
#define XFLOAT(value) (value ? [NSNumber numberWithDouble:(double)value] : [NSNumber numberWithDouble:(double)0.0])
#define XBOOL(value) (value ? [NSNumber numberWithBool:value] : [NSNumber numberWithBool:NO])
#define XNULL [NSNull null]
#define $false ((NSNumber*)kCFBooleanFalse)
#define $true  ((NSNumber*)kCFBooleanTrue)

// even shorter versions
#define $I(value) XINT(value)
#define $F(value) XFLOAT(value)
#define $B(value) XBOOL(value)
#define $S(...)   [NSString stringWithFormat: __VA_ARGS__]

#define XMCOPY(_obj) [[_obj mutableCopy] autorelease]
#define xcopy(_obj) [[_obj copy] autorelease]

// sorting
#define XLT(a,b) ([a compare:b] == NSOrderedAscending)
#define XGT(a,b) ([a compare:b] == NSOrderedDescending)
#define XEQ(a,b) ([a compare:b] == NSOrderedSame)

// notification center
#define XNC [NSNotificationCenter defaultCenter]
#define XNCADD(n,sel) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:n object:nil];
#define XNCREMOVE [[NSNotificationCenter defaultCenter] removeObserver:self];
#define XNCPOST(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];

// selector apply
#define XAPPLY(target, sel)  if([(id)target respondsToSelector:@selector(sel)]) { [(id)target performSelector:@selector(sel)]; }
#define XAPPLY1(target, sel, obj)  if([(id)target respondsToSelector:@selector(sel:)]) { [(id)target performSelector:@selector(sel:) withObject:obj]; }

#define XAPPLYSEL(target, sel)  if([target respondsToSelector:sel]) { [(id)target performSelector:sel]; }
#define XAPPLYSEL1(target, sel, obj)  if([target respondsToSelector:sel]) { [(id)target performSelector:sel withObject:obj]; }

#define XDATA2UTF8STRING(data) [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]
#define XUTF8STRING2DATA(s) [s dataUsingEncoding:NSUTF8StringEncoding]

// user defaults
#define XDEL_OBJECT(k) [[NSUserDefaults standardUserDefaults] removeObjectForKey:k];
#define XGET_OBJECT(v) [[NSUserDefaults standardUserDefaults] objectForKey:v]
#define XSET_OBJECT(k,v) [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
#define XGET_STRING(v) [[NSUserDefaults standardUserDefaults] stringForKey:v]
#define XSET_STRING(k,v) [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
#define XGET_FLOAT(v) [[NSUserDefaults standardUserDefaults] floatForKey:v]
#define XSET_FLOAT(k,v) [[NSUserDefaults standardUserDefaults] setFloat:v forKey:k];
#define XGET_BOOL(v) [[NSUserDefaults standardUserDefaults] boolForKey:v]
#define XSET_BOOL(k,v) [[NSUserDefaults standardUserDefaults] setBool:v forKey:k];
#define XGET_INT(v) [[NSUserDefaults standardUserDefaults] integerForKey:v]
#define XSET_INT(k,v) [[NSUserDefaults standardUserDefaults] setInteger:v forKey:k];
#define XSYNC [[NSUserDefaults standardUserDefaults] synchronize];


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
