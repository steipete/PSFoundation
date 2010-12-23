//
//  PSMacros.h
//
//  Created by Peter Steinberger on 03.05.10.
//  Contains stuff from Dirk Holtwick - thanks for sharing!
//

// compiler help
#define INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }
#define STRING_IS_EMPTY_OR_NIL( _STRING ) ( _STRING == nil || [_STRING isEmptyOrWhitespace] )
#define VERIFIED_CLASS(className) ((className *) NSClassFromString(@"" # className))

// http://www.wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing) {
	return thing == nil ||
  ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
  ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

// CGRect
#define PSRectClearCoords(_CGRECT) CGRectMake(0, 0, _CGRECT.size.width, _CGRECT.size.height)
#define CGRectClearCoords(_CGRECT) PSRectClearCoords(_CGRECT) // legacy

// color
#define SETTINGS_TEXT_COLOR	RGBCOLOR(57, 85, 135)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define XHEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define XHEXCOLOR_ALPHA(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(x) (M_PI * 180.0 / (x))

// Time Macros
#define MTTimeIntervalMilliseconds(x) x / 1000.
#define MTTimeIntervalSeconds(x) x
#define MTTimeIntervalMinutes(x) x * 60.
#define MTTimeIntervalHours(x) x * 3600.
#define MTTimeIntervalDays(x) x * 3600. * 24.

// Resource Path used with Folder References
#define MTGetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]


// Short hand NSLocalizedString, doesn't need 2 parameters
#define LocalizedString(s) NSLocalizedString(s,s)

// LocalizedString with an additionl parameter for formatting
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

// http://code.google.com/p/cocoalumberjack/wiki/XcodeTricks - compiles most log messages out of the release build, but not all!
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_INFO;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

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
#define MTApplicationDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
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

// collection shortcuts
#define XDEFAULT(_value, _default) ([[NSNull null] isEqual:(_value)] ? (_default) : (_value))
#define XFMT(...) [NSString stringWithFormat: __VA_ARGS__]
#define XARRAY(...) [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define XDICT(...) [NSDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define XMARRAY(...) [NSMutableArray arrayWithObjects: __VA_ARGS__, nil]
#define XMDICT(...) [NSMutableDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]

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
