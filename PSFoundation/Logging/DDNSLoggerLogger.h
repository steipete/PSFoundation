//
//  DDNSLoggerLogger.h
//  PSFoundation
//
//  Created by Peter Steinberger on 26.10.10.
//

#import "DDLog.h"

@interface DDNSLoggerLogger : DDAbstractLogger <DDLogger>

+ (DDNSLoggerLogger *)sharedInstance;

// Inherited from DDAbstractLogger

// - (id <DDLogFormatter>)logFormatter;
// - (void)setLogFormatter:(id <DDLogFormatter>)formatter;

@end
