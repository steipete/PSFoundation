// COMMON FILE: Common

//
//  ColorLog.m
//  ColorLog
//
//  Created by Uncle MiF on 9/15/10.
//  Copyright 2010 Deep IT. All rights reserved.
//

#import "ColorLog.h"

#ifdef NSLog
#undef NSLog
#endif

void (*__ColorLog_NSLog)(NSString * fmt,...) = NSLog;// to prevent false warning about format string

BOOL IsXcodeColorsEnabled()
{
	char* xcEnv = getenv("XcodeColors");
	return (xcEnv && !strcmp(xcEnv, "YES"));
}

NSString* StripXcodeColors(NSString* str,...)
{
	if (!str)
		return nil;
	
	NSRange range;
	range = [str rangeOfString:@"\033[0"];
	
	if (range.location == NSNotFound)
		return str;
	
	NSMutableString * res = [NSMutableString stringWithString:str];
	
	do {
		NSRange end = range;
		end.location += range.length;
		end.length = [res length] - end.location;
		if (end.length > 4)
			end.length = 4;
		end = [res rangeOfString:@"m" options:NSLiteralSearch range:end];
		if (end.location == NSNotFound)
			break;
		[res replaceCharactersInRange:NSMakeRange(range.location, end.location - range.location + end.length) withString:@""];
		range = [res rangeOfString:@"\033[0"];
	} while(range.location != NSNotFound);
	
	return res;
}

NSString* AllowXcodeColors(NSString* str,...)
{
	return str;
}
