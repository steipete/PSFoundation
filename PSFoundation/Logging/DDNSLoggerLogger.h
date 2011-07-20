//
//  DDNSLoggerLogger.h
//  PSFoundation
//
//  Created by Peter Steinberger on 26.10.10.
//

#import "DDLog.h"

@interface DDNSLoggerLogger : DDAbstractLogger <DDLogger>

+ (DDNSLoggerLogger *)sharedInstance;

@end
