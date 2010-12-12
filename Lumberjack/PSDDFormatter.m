//
//  PSDDFormatter.m
//  Created by Peter Steinberger on 08.09.10.
//

#import "PSDDFormatter.h"


@implementation PSDDFormatter

- (id)init {
  if((self = [super init]))
  {
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
  }
  return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
  NSString *logLevel;
  switch (logMessage->logFlag) {
    case LOG_FLAG_ERROR : logLevel = @"Err!"; break;
    case LOG_FLAG_WARN  : logLevel = @"Warn"; break;
    case LOG_FLAG_INFO  : logLevel = @"    "; break;
    default             : logLevel = @"Verb"; break;
  }

  NSString *dateAndTime = [dateFormatter stringFromDate:(logMessage->timestamp)];
  NSString *logMsg = logMessage->logMsg;

  return [NSString stringWithFormat:@"%@(%@) %@ %@ <%d>", dateAndTime, [logMessage threadID], logLevel, logMsg, logMessage->lineNumber];
}

- (void)dealloc {
  MCRelease(dateFormatter);
  [super dealloc];
}

@end
