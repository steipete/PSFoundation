//
//  PSDDFormatter.h
//  Created by Peter Steinberger on 08.09.10.
//

#import "DDLog.h"

@interface PSDDFormatter : NSObject <DDLogFormatter> {
  NSDateFormatter *dateFormatter;
}

@end
