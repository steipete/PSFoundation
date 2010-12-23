// COMMON FILE: Common

//
//  ColorLog.h
//  ColorLog
//
//  Created by Uncle MiF on 9/15/10.
//  Copyright 2010 Deep IT. All rights reserved.
//

// First of all, the SIMBL must be installed: http://culater.net/software/SIMBL/SIMBL.php
// Next, XcodeColors.bundle - plugin must be installed to ~/Library/Application Support/SIMBL/Plugins/
// Xcode must be restarted to apply changes.
// Supported Xcode 3 and 4. Leopard 10.5 or Snow Leopard 10.6. Autorelease Pool or GC environment.

/*
	Usage demo:
	
	#import "ColorLog.h"
	
	...
	
	NSLog(@"You can simple log " LCL_BLUE "and " LCL_GREEN "use " LCL_RED "colors" LCL_RESET);
	
	// or use safe function that strip colors if no plugn found:
	
	NSLogColor(@"Hello Standard world!\n"
	
	LBCL_WHITE												
	
	LCL_RED "Hello Red world!\n"
	LCL_GREEN "Hello Green world!\n"
	LCL_YELLOW "Hello Yellow world!\n"
	LCL_BLUE "Hello Blue world!\n"
	LCL_MAGENTA "Hello Magenta world!\n"
	LCL_CYAN "Hello Cyan world!\n"
	LCL_WHITE "Hello White world!\n"
	
	LCL_RESET "Hello Standard world again!");
	
	NSLogColor(@"New Standard line");
	NSLogColor(LBCL_GREEN @"New Green-Br line");// background and color continues until next color set
	NSLogColor(@"Next Green-Bg line");
	NSLogColor(@"Next Green-Bg line");
	NSLogColor(LBCL_GREEN LCL_BLUE @"Next Blue Green-Bg line");
	NSLogColor(@"Last Green-Bg line" LCL_RESET);
	NSLogColor(LBCL_YELLOW @"New line on Yellow-Bg");	
	
	NSLogReset();// it works as split line also
	
	NSLogRed(LBCL_BLUE @"I'm Red line on Blue-Bg");
	NSLogGreen(@"I'm Green line");
	NSLogYellow(@"I'm Yellow line");
	NSLogBlue(LBCL_GREEN @"I'm Blue line on Green-Bg");
	NSLogMagenta(@"I'm Magenta line");
	NSLogCyan(LBCL_BLACK @"I'm Cyan line on Black-Bg");
	NSLogWhite(LBCL_RED @"I'm White line on Red-Bg " LCL_BLUE @"Blue cut " LCL_GREEN @"Green cut");		
	
	*/

/*
	There are known issues:
	
	1)
	
	To prevent Xcode crash, we don't delete special \033[..m (ESC-sequences) from the console text internal storage,
	however we replace all of them to \035 - logical group marker instead, that does nothing and invisible.
	So, you actually don't see special characters on colored output but you may invisble-touch them while copy-paste to TextEdit.

	Here is solution if you need to full clear output: copy and paste a log to the vi, then run one command:

	:%s/Ctrl-v]//g
	
	Where Ctrl-v] means you press Ctrl-v then Ctrl-]
	
	Or you can even disable XcodeColors module to see results as is:
	
	setenv("XcodeColors", "NO", 1);
	
	or by executable environment configuration
	
	2)
	
	Sometimes, rarely, colors may be shown not as need (ignored).
	It may happen due to limited lazy console refresh.
	
	*/

#import <Foundation/Foundation.h>

// You can use simple NSLogColor (as NSLog replacement) to automatically strip color specific sequences from the format string if it needs

// Only restricted ANSI colors set available now:

// Foreground
#define LCL_BLACK				@"\033[0;30m"
#define LCL_RED						@"\033[0;31m"
#define LCL_GREEN				@"\033[0;32m"
#define LCL_YELLOW			@"\033[0;33m"
#define LCL_BLUE					@"\033[0;34m"
#define LCL_MAGENTA		@"\033[0;35m"
#define LCL_CYAN					@"\033[0;36m"
#define LCL_WHITE				@"\033[0;37m"

// Background
#define LBCL_BLACK			@"\033[0;40m"
#define LBCL_RED					@"\033[0;41m"
#define LBCL_GREEN			@"\033[0;42m"
#define LBCL_YELLOW		@"\033[0;43m"
#define LBCL_BLUE				@"\033[0;44m"
#define LBCL_MAGENTA	@"\033[0;45m"
#define LBCL_CYAN				@"\033[0;46m"
#define LBCL_WHITE			@"\033[0;47m"

// Reset colors
#define LCL_RESET				@"\033[0m"

/* To adjust colors
	
	There are only 7 basic colors for the Foreground and 7 for the Background but you can adjust all of them.
	Color names are black, red, green etc - as defined in appropriate define macros.
	
	To define a custom color for predefined colors use the following command format:
	
	defaults write com.apple.Xcode ColorLog_blackColor -TYPE YOUR_VALUE
	
	where TYPE maybe simple 'string'
	then you can define value as +method name of std NSColor class
	like 'blackColor' method:
	
	defaults write com.apple.Xcode ColorLog_blackColor -string blackColor
	
	or in RGBA format with 0..1 floating point number for every component:
	
	defaults write com.apple.Xcode ColorLog_greenBackgroundColor -string 0.1,0.9,0.1,0.5
	
	defaults write com.apple.Xcode ColorLog_redBackgroundColor -string 0.9,0.1,0.1,0.5
	
	or even set color option as NSColor archived as standard NSData.
	
	*/

BOOL IsXcodeColorsEnabled();

NSString* StripXcodeColors(NSString* str,...) __attribute__((format(__NSString__, 1, 2)));// format checking is enabled
NSString* AllowXcodeColors(NSString* str,...) __attribute__((format(__NSString__, 1, 2)));// just returns the same string, it needs for format chacking

extern void (*__ColorLog_NSLog)(NSString * fmt,...);// to prevent false warning about format string

#define _LCL(str,...) (IsXcodeColorsEnabled() ? AllowXcodeColors((str),##__VA_ARGS__) : StripXcodeColors((str),##__VA_ARGS__))

#if (defined DINSLogFilter) && (defined NSLog)

#define NSLogColor(fmt,...) NSLog(_LCL((fmt),##__VA_ARGS__),##__VA_ARGS__)

// DINSLogFilter extensions:

#define NSLogColorZone(zone,fmt,...) NSLogZone(zone,_LCL((fmt),##__VA_ARGS__),##__VA_ARGS__)
#define NSLogColorDebug(fmt,...) NSLogDebug(_LCL((fmt),##__VA_ARGS__),##__VA_ARGS__)
#define NSLogColorZoneDebug(zone,fmt,...) NSLogZoneDebug(zone,_LCL((fmt),##__VA_ARGS__),##__VA_ARGS__)

#else

#define NSLogColor(fmt,...) __ColorLog_NSLog(_LCL((fmt),##__VA_ARGS__),##__VA_ARGS__)

#endif

// Useful pre-colored logs:

#define NSLogBlack(fmt,...) NSLogColor((LCL_BLACK fmt LCL_RESET),##__VA_ARGS__)
#define NSLogRed(fmt,...) NSLogColor((LCL_RED fmt LCL_RESET),##__VA_ARGS__)
#define NSLogGreen(fmt,...) NSLogColor((LCL_GREEN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogYellow(fmt,...) NSLogColor((LCL_YELLOW fmt LCL_RESET),##__VA_ARGS__)
#define NSLogBlue(fmt,...) NSLogColor((LCL_BLUE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogMagenta(fmt,...) NSLogColor((LCL_MAGENTA fmt LCL_RESET),##__VA_ARGS__)
#define NSLogCyan(fmt,...) NSLogColor((LCL_CYAN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogWhite(fmt,...) NSLogColor((LCL_WHITE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogReset(...) NSLogColor(LCL_RESET)

// DINSLogFilter extensions:

#if (defined DINSLogFilter) && (defined NSLog)

#define NSLogBlackZone(zone,fmt,...) NSLogColorZone(zone,(LCL_BLACK fmt LCL_RESET),##__VA_ARGS__)
#define NSLogRedZone(zone,fmt,...) NSLogColorZone(zone,(LCL_RED fmt LCL_RESET),##__VA_ARGS__)
#define NSLogGreenZone(zone,fmt,...) NSLogColorZone(zone,(LCL_GREEN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogYellowZone(zone,fmt,...) NSLogColorZone(zone,(LCL_YELLOW fmt LCL_RESET),##__VA_ARGS__)
#define NSLogBlueZone(zone,fmt,...) NSLogColorZone(zone,(LCL_BLUE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogMagentaZone(zone,fmt,...) NSLogColor(zone,(LCL_MAGENTA fmt LCL_RESET),##__VA_ARGS__)
#define NSLogCyanZone(zone,fmt,...) NSLogColorZone(zone,(LCL_CYAN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogWhiteZone(zone,fmt,...) NSLogColorZone(zone,(LCL_WHITE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogResetZone(zone,...) NSLogColorZone(zone,LCL_RESET)

#define NSLogBlackDebug(fmt,...) NSLogColorDebug((LCL_BLACK fmt LCL_RESET),##__VA_ARGS__)
#define NSLogRedDebug(fmt,...) NSLogColorDebug((LCL_RED fmt LCL_RESET),##__VA_ARGS__)
#define NSLogGreenDebug(fmt,...) NSLogColorDebug((LCL_GREEN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogYellowDebug(fmt,...) NSLogColorDebug((LCL_YELLOW fmt LCL_RESET),##__VA_ARGS__)
#define NSLogBlueDebug(fmt,...) NSLogColorDebug((LCL_BLUE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogMagentaDebug(fmt,...) NSLogColorDebug((LCL_MAGENTA fmt LCL_RESET),##__VA_ARGS__)
#define NSLogCyanDebug(fmt,...) NSLogColorDebug((LCL_CYAN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogWhiteDebug(fmt,...) NSLogColorDebug((LCL_WHITE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogResetDebug(...) NSLogColorDebug(LCL_RESET)

#define NSLogBlackZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_BLACK fmt LCL_RESET),##__VA_ARGS__)
#define NSLogRedZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_RED fmt LCL_RESET),##__VA_ARGS__)
#define NSLogGreenZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_GREEN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogYellowZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_YELLOW fmt LCL_RESET),##__VA_ARGS__)
#define NSLogBlueZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_BLUE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogMagentaZoneDebug(zone,fmt,...) NSLogColorDebug(zone,(LCL_MAGENTA fmt LCL_RESET),##__VA_ARGS__)
#define NSLogCyanZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_CYAN fmt LCL_RESET),##__VA_ARGS__)
#define NSLogWhiteZoneDebug(zone,fmt,...) NSLogColorZoneDebug(zone,(LCL_WHITE fmt LCL_RESET),##__VA_ARGS__)
#define NSLogResetZoneDebug(zone,...) NSLogColorZoneDebug(zone,LCL_RESET)

#endif