// 
//  VTPG_Common.m
//
//  Copyright (c) 2008-2010, Vincent Gable.
//  http://vincentgable.com
//
//  Based off http://www.dribin.org/dave/blog/archives/2008/09/22/convert_to_nsstring/
//

#pragma once

NSString * VTPG_DDToStringFromTypeAndValue(const char * typeCode, void * value);

// WARNING: if NO_LOG_MACROS is #define-ed, than THE ARGUMENT WILL NOT BE EVALUATED

#ifndef NO_LOG_MACROS
#define Log(_X_) do{\
	__typeof__(_X_) _Y_ = (_X_);\
	const char * _TYPE_CODE_ = @encode(__typeof__(_X_));\
	NSString *_STR_ = VTPG_DDToStringFromTypeAndValue(_TYPE_CODE_, &_Y_);\
	if(_STR_)\
		DDLogInfo(@"%s = %@", #_X_, _STR_);\
	else\
		DDLogInfo(@"Unknown _TYPE_CODE_: %s for expression %s in function %s, file %s, line %d", _TYPE_CODE_, #_X_, __func__, __FILE__, __LINE__);\
}while(0)

// compatibility
#define MTLog(_X_) Log(_X_)

#define LOG_NS(...) NSLog(__VA_ARGS__)
#define LOG_FUNCTION()	NSLog(@"%s", __func__)

#else /* NO_LOG_MACROS */

#define Log(_X_)
#define LOG_NS(...)
#define LOG_FUNCTION()
#define MTLog(_X_)
#endif /* NO_LOG_MACROS */
