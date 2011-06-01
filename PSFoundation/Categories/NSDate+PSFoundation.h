//
//  NSDate+PSFoundation.m
//
//  Created by Peter Steinberger on 23.05.09.
//

@interface NSDate (PSFoundation)

- (NSString *)prettyDate;
- (NSString *)prettyDateWithReference:(NSDate *)reference;
- (NSString *)prettyDateWithReference:(NSDate *)reference relativeMonth:(BOOL)relativeMonth;
- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style;
- (NSString *)dateStringWithStyle:(NSDateFormatterStyle)style time:(NSDateFormatterStyle)timeStyle;

+ (NSDate *)ps_todayMidnight;
+ (NSDate *)ps_tomorrowMidnight;
+ (NSDate *)ps_yesterday;
+ (NSDate *)ps_tomorrow;
+ (NSDate *)ps_thisWeek;
+ (NSDate *)ps_lastWeek;
+ (NSDate *)ps_thisMonth;
+ (NSDate *)ps_lastMonth;

+ (NSDate *)ps_oneMinuteFuture;

- (BOOL) isBefore:(NSDate*)otherDate;
- (BOOL) isAfter:(NSDate*)otherDate;

@end
