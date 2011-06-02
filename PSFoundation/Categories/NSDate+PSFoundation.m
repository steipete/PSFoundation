//
//  NSDate+PSFoundation.m
//  PSFoundation
//
//  Created by Peter Steinberger on 23.05.09.
//  Licensed under MIT.  All rights reserved.
//

#import "NSDate+PSFoundation.h"

@implementation NSDate (PSFoundation)

static NSDateFormatter *dateFormatter = nil;

- (NSString *)prettyDateWithReference:(NSDate *)reference relativeMonth:(BOOL)relativeMonth
{
  float diff = [reference timeIntervalSinceDate:self];
  float distance = floor(diff);

  if (distance < 60) {
    //self.timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    return NSLocalizedString(@"just now", @"");
  }
  else if (distance < 60 * 60) {
    distance = distance / 60;
    return [NSString stringWithFormat:@"%d %@", (int)distance, ((int)distance == 1) ? NSLocalizedString(@"minute", @"") : NSLocalizedString(@"mins", @"")];
  }
  else if (distance < 60 * 60 * 24) {
    distance = distance / 60 / 60;
    return [NSString stringWithFormat:@"%d %@", (int)distance, ((int)distance == 1) ? NSLocalizedString(@"hour", @"") : NSLocalizedString(@"hours", @"")];
  }
  else if (distance < 60 * 60 * 24 * 7) {
    distance = distance / 60 / 60 / 24;
    return [NSString stringWithFormat:@"%d %@", (int)distance, ((int)distance == 1) ? NSLocalizedString(@"day", @"") : NSLocalizedString(@"days", @"")];
  }
  else if (distance < 60 * 60 * 24 * 7 * 4) {
    distance = distance / 60 / 60 / 24 / 7;
    return [NSString stringWithFormat:@"%d %@", (int)distance, ((int)distance == 1) ? NSLocalizedString(@"week", @"") : NSLocalizedString(@"weeks", @"")];
  }
  else if (relativeMonth && distance < 60 * 60 * 24 * 7 * 4 * 12) {
    distance = distance / 60 / 60 / 24 / 7 / 4;
    return [NSString stringWithFormat:@"%d %@", (int)distance, ((int)distance == 1) ? NSLocalizedString(@"month", @"") : NSLocalizedString(@"months", @"")];
  }
  else {
    if (dateFormatter == nil) {
      dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateStyle:NSDateFormatterShortStyle];
      [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return [dateFormatter stringFromDate:self];
  }
}

- (NSString *)prettyDateWithReference:(NSDate *)reference {
  return [self prettyDateWithReference:[NSDate date] relativeMonth:NO];
}

- (NSString *)prettyDate {
  return [self prettyDateWithReference:[NSDate date] relativeMonth:NO];
}


- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style {
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setDateStyle:style];
  return [dateFormatter stringFromDate:self];
}

- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style time:(NSDateFormatterStyle)timeStyle {
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setDateStyle:style];
  [dateFormatter setTimeStyle:timeStyle];
  return [dateFormatter stringFromDate:self];
}

+ (NSDate *)ps_todayMidnight {
  NSDate *today = [NSDate date];

  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

  NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
  NSDateComponents *components = [gregorian components:unitFlags fromDate:today];
  components.hour = 0;
  components.minute = 0;

  NSDate *todayMidnight = [gregorian dateFromComponents:components];
  [gregorian release];

  return todayMidnight;
}

// http://stackoverflow.com/questions/181459/is-there-a-better-way-to-find-midnight-tomorrow
+ (NSDate *)ps_tomorrowMidnight {
  NSDate *today = [NSDate date];

  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = 1;
  NSDate *tomorrow = [gregorian dateByAddingComponents:components toDate:today options:0];
  [components release];

  NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
  components = [gregorian components:unitFlags fromDate:tomorrow];
  components.hour = 0;
  components.minute = 0;

  NSDate *tomorrowMidnight = [gregorian dateFromComponents:components];

  [gregorian release];
  return tomorrowMidnight;
}

// All intervals taken from Google
+ (NSDate *)ps_yesterday {
  return [[NSDate date] addTimeInterval: -86400.0];
}

+ (NSDate *)ps_tomorrow {
  return [[NSDate date] addTimeInterval: 86400.0];
}

+ (NSDate *)ps_thisWeek {
  return [[NSDate date] addTimeInterval: -604800.0];
}

+ (NSDate *)ps_lastWeek {
  return [[NSDate date] addTimeInterval: -1209600.0];
}

+ (NSDate *)ps_thisMonth {
  return [[NSDate date] addTimeInterval: -2629743.83]; // Use NSCalendar for exact # of days
}

+ (NSDate *)ps_lastMonth {
  return [[NSDate date] addTimeInterval: -5259487.66];  // Use NSCalendar for exact # of days
}

+ (NSDate *)ps_oneMinuteFuture {
  return [[NSDate date] addTimeInterval: 60];
}

- (BOOL) isBefore:(NSDate*)otherDate {
	return [self timeIntervalSinceDate:otherDate] < 0;
}

- (BOOL) isAfter:(NSDate*)otherDate {
	return [self timeIntervalSinceDate:otherDate] > 0;
}

@end
