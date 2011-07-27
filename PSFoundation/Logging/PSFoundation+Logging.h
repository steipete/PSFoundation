//
//  PSFoundation+Logging.h
//  PSFoundation
//
//  Includes code by the following:
//   - Vincent Gable.  2008.
//
//  References:
//   - http://www.dribin.org/dave/blog/archives/2008/09/22/convert_to_nsstring/
//

#import "DDLog.h"

// for function pass entering
#define HOLogPing() NSLog(@"%s", __PRETTY_FUNCTION__);

// block asserts for non-debug builds ("the ugly tree")
#ifndef DEBUG
  // block Log() macro
  #define Log(_X_)
  #define LOG_FUNCTION()
#else
  #define Log(_X_) do{\
  __typeof__(_X_) _Y_ = (_X_);\
  const char * _TYPE_CODE_ = @encode(__typeof__(_X_));\
  NSString *_STR_ = VTPG_DDToStringFromTypeAndValue(_TYPE_CODE_, &_Y_);\
  if(_STR_)\
  DDLogInfo(@"%s = %@", #_X_, _STR_);\
  else \
  DDLogInfo(@"Unknown _TYPE_CODE_: %s for expression %s in function %s, file %s, line %d", _TYPE_CODE_, #_X_, __func__, __FILE__, __LINE__);\
  } while(0)
  #define LOG_FUNCTION()	NSLog(@"%s", __func__)
#endif

// http://code.google.com/p/cocoalumberjack/wiki/XcodeTricks - compiles most log messages out of the release build, but not all!
#ifdef DEBUG
static const int ddLogLevel = ((1 << 0) | (1 << 1) | (1 << 2));
#else
static const int ddLogLevel = ((1 << 0) | (1 << 1));
#endif

NSString *VTPG_DDToStringFromTypeAndValue(const char * typeCode, void * value);