//
//  GlobalMacros.h
//
//  Created by Peter Steinberger on 03.05.10.
//

#import <CoreFoundation/CoreFoundation.h>
#import "Macros/SynthesizeSingleton.h"
#import "Lumberjack/DDLog.h"
#import "HOLog.h"

// compiler help
#define INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }
#define STRING_IS_EMPTY_OR_NIL( _STRING ) ( _STRING == nil || [_STRING isEmptyOrWhitespace] )

// http://www.wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing) {
	return thing == nil ||
  ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
  ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

// CGRect
#define PSRectClearCoords(_CGRECT) CGRectMake(0, 0, _CGRECT.size.width, _CGRECT.size.height)
#define CGRectClearCoords(_CGRECT) PSRectClearCoords(_CGRECT) // for compability reasons

#define $false ((NSNumber*)kCFBooleanFalse)
#define $true  ((NSNumber*)kCFBooleanTrue)

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#define UIApp [UIApplication sharedApplication].delegate

// Short hand NSLocalizedString, doesn't need 2 parameters
#define LocalizedString(s) NSLocalizedString(s,s)
// LocalizedString with an additionl parameter for formatting
#define LocalizedStringWithFormat(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]

// compatibility with old gtm logger
/*
#define GTMLoggerVerbose DDLogVerbose
#define GTMLoggerInfo DDLogInfo
#define GTMLoggerWarning DDLogWarn
#define GTMLoggerError DDLogError
*/

// for function pass entering
#define DDLogFunction() DDLogInfo(@"-- logged --");

#define RELEASE MCRelease // backwards compatibility

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
static const int ddLogLevel = LOG_LEVEL_WARN; //LOG_LEVEL_INFO;
#endif

// http://www.cimgf.com/2010/05/02/my-current-prefix-pch-file/

// use like PSAssert(anAsset != nil, @"Asset cannot be nil");
#define PSAssertM(condition, message) do { if(condition) { DDLogWarn(@"asserted with %@", message); assert(condition && message); }} while(0)
#define PSAssert(condition) do { if(condition) { DDLogWarn(@"asserted!");  assert(condition); }} while(0)
#define PSAssertReturnNil(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return nil; }} while (0)
#define PSAssertReturnNO(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return NO; }} while (0)
#define PSAssertReturn(condition)  do { if(condition) { DDLogWarn(@"PSAssertReturnNil: Condition is true!"); PSAssert(YES); return; }} while (0)

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

// survives when NS_BLOCK_ASSERTIONS is set and simply mutates
// http://vgable.com/blog/2008/12/04/nsassert-considered-harmful/
#define ZAssert(condition, ...) do { if (!(condition)) { AssertLog(__VA_ARGS__); }} while(0)

// color
#define SETTINGS_TEXT_COLOR	RGB(57, 85, 135
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// thanks Landon Fuller
#define VERIFIED_CLASS(className) ((className *) NSClassFromString(@"" # className))
