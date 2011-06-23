//
//  DDNSLoggerLogger.m
//  Created by Peter Steinberger on 26.10.10.
//

#import "DDNSLoggerLogger.h"

// NSLogger is needed: http://github.com/fpillet/NSLogger
#import "LoggerClient.h"

@implementation DDNSLoggerLogger

static DDNSLoggerLogger *sharedInstance;

// The logger instance we use
static Logger *_DDNSLogger_logger = nil;

/**
 * The runtime sends initialize to each class in a program exactly one time just before the class,
 * or any class that inherits from it, is sent its first message from within the program. (Thus the
 * method may never be invoked if the class is not used.) The runtime sends the initialize message to
 * classes in a thread-safe manner. Superclasses receive this message before their subclasses.
 *
 * This method may also be called directly (assumably by accident), hence the safety mechanism.
 **/
+ (void)initialize
{
	static BOOL initialized = NO;
	if (!initialized)
	{
		initialized = YES;

		sharedInstance = [[DDNSLoggerLogger alloc] init];
	}
}

+ (DDNSLoggerLogger *)sharedInstance
{
	return sharedInstance;
}

- (id)init {
	if (sharedInstance != nil) {
        PS_RELEASE(self);
		return nil;
	}

	if ((self = [super init]))
	{
    // create and remember the logger instance
    _DDNSLogger_logger = LoggerInit();

    // activate the logger
    LoggerStart(_DDNSLogger_logger);
	}
	return self;
}

- (void)logMessage:(DDLogMessage *)logMessage
{
	NSString *logMsg = logMessage->logMsg;

	if (formatter)
	{
    // formatting is supported but not encouraged!
		logMsg = [formatter formatLogMessage:logMessage];
	}else {
    // apply own mini-formatter here!
    logMsg = [NSString stringWithFormat:@"%@ <%d>", logMsg, logMessage->lineNumber];
  }

	if (logMsg)
	{
    int nsloggerLogLevel;
		switch (logMessage->logFlag)
		{
      // NSLogger log levels start a 0, the bigger the number,
      // the more specific / detailed the trace is meant to be
			case LOG_FLAG_ERROR : nsloggerLogLevel = 0; break;
			case LOG_FLAG_WARN  : nsloggerLogLevel = 1; break;
			case LOG_FLAG_INFO  : nsloggerLogLevel = 2; break;
			default : nsloggerLogLevel = 3; break;
		}

    LogMessage([logMessage fileName], nsloggerLogLevel, @"%@", logMsg);
	}
}

- (NSString *)loggerName
{
	return @"cocoa.lumberjack.NSLogger";
}

@end
