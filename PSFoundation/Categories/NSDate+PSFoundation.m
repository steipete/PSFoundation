//
//  NSDate+PSFoundation.m
//  PSFoundation
//

#import "NSDate+PSFoundation.h"
#import "NSObject+Utilities.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@implementation NSDate (PSFoundation)

+ (NSDate *)dateWithComponents:(NSDateComponents *)components {
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

#pragma mark Relative Dates

+ (NSDate *)dateOneMinuteFromNow {
    return [[NSDate date] addTimeInterval: 60];	    
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes {
    return [NSDate dateWithMinutesFromNow:-1*dMinutes];
}

+ (NSDate *)dateTodayMidnight {
    NSDate *today = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:today];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [NSDate dateWithComponents:components];
}

+ (NSDate *)dateYesterday {
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateTomorrowMidnight {
    NSDate *tomorrow = [NSDate dateTomorrow];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;    
    NSDateComponents *components = [cal components:unitFlags fromDate:tomorrow];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [NSDate dateWithComponents:components];
}

+ (NSDate *)dateTomorrow {
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours {
    return [[NSDate date] dateByAddingHours:dHours];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours {
    return [[NSDate date] dateBySubtractingHours:dHours];
}

+ (NSDate *)dateThisWeek {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:[NSDate date]];
    components.weekday = 0;
    return [NSDate dateWithComponents:components];
}

+ (NSDate *)dateLastWeek {
    NSDate *newDate = [[NSDate date] dateBySubtractingDays:7];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:newDate];
    components.weekday = 0;
    return [NSDate dateWithComponents:components];
}

+ (NSDate *)dateThisMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    components.day = 0;
    return [NSDate dateWithComponents:components];
    
}

+ (NSDate *)dateLastMonth {
    NSDate *newDate = [[NSDate date] dateBySubtractingDays:30];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newDate];
    components.day = 0;
    return [NSDate dateWithComponents:components];
}

#pragma mark Comparing Dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
	NSDateComponents *components1 = self.components;
	NSDateComponents *components2 = aDate.components;
	return (components1.year == components2.year && components1.month == components2.month && components1.day == components2.day);
}

- (BOOL)isToday {
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
	NSDateComponents *components1 = self.components;
	NSDateComponents *components2 = aDate.components;
	
	if (components1.week != components2.week)
        return NO;
	
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)isThisWeek {
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    NSDate *today = [NSDate date];
    return (self.year == today.year);
}

- (BOOL)isThisYear {
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSDate *today = [NSDate date];
    return (self.year == today.year + 1);
}

- (BOOL)isLastYear {
    NSDate *today = [NSDate date];
    return (self.year == today.year - 1);
}

- (BOOL) isEarlier: (NSDate *) aDate {
	return ([self earlierDate:aDate] == self);
}

- (BOOL) isLater: (NSDate *) aDate {
	return ([self laterDate:aDate] == self);
}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays:(NSInteger)dDays {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingDays:(NSInteger)dDays {
	return [self dateByAddingDays:-1*dDays];
}

- (NSDate *) dateByAddingHours:(NSInteger)dHours {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours:(NSInteger)dHours {
	return [self dateByAddingHours:-1*dHours];
}

- (NSDate *) dateByAddingMinutes:(NSInteger)dMinutes {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes {
	return [self dateByAddingMinutes:-1*dMinutes];
}

#pragma mark Retrieving Intervals

- (NSInteger)minutesSinceDate:(NSDate *)aDate {
	return [self timeIntervalSinceDate:aDate] / D_MINUTE;
}

- (NSInteger)minutesUntilDate:(NSDate *)aDate {
	return [aDate timeIntervalSinceDate:self] / D_MINUTE;
}

- (NSInteger)hoursSinceDate:(NSDate *)aDate {
	return [self timeIntervalSinceDate:aDate] / D_HOUR;
}

- (NSInteger)hoursUntilDate:(NSDate *)aDate {
	return [aDate timeIntervalSinceDate:self] / D_HOUR;
}

- (NSInteger)daysSinceDate:(NSDate *)aDate {
	return [self timeIntervalSinceDate:aDate] / D_DAY;
}

- (NSInteger)daysUntilDate:(NSDate *)aDate {
	return [aDate timeIntervalSinceDate:self] / D_DAY;
}

#pragma mark Decomposing Dates

- (NSDateComponents *)components {
    @synchronized(self) {
        return [[NSCalendar currentCalendar] components:NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit fromDate:self];        
    }
}

- (NSInteger) nearestHour {
	return [NSDate dateWithMinutesFromNow:30].hour;
}

- (NSInteger) hour {
    return self.components.hour;
}

- (NSInteger) minute {
    return self.components.minute;
}

- (NSInteger) seconds {
    return self.components.second;
}

- (NSInteger) day {
	return self.components.day;
}

- (NSInteger) month {
	return self.components.month;
}

- (NSInteger) week {
	return self.components.week;
}

- (NSInteger) weekday {
	return self.components.weekday;
}

- (NSInteger) weekdayOrdinal {
	return self.components.weekdayOrdinal;
}

- (NSInteger) year {
    return self.components.year;
}

- (NSString *)naturalDate {
    return [self naturalDateWithReference:[NSDate date]];
}

- (NSString *)naturalDateWithReference:(NSDate *)reference {
    NSTimeInterval diff = [reference timeIntervalSinceDate:self];
    NSInteger distance = floor(diff);
    
    if (distance < 60) {
        //self.timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
        return NSLocalizedString(@"just now", @"");
    } else if (distance < 60 * 60) {
        distance /= D_MINUTE;
        return [NSString stringWithFormat:@"%d %@", distance, (distance == 1) ? NSLocalizedString(@"minute", @"") : NSLocalizedString(@"mins", @"")];
    } else if (distance < 60 * 60 * 24) {
        distance /= D_HOUR;
        return [NSString stringWithFormat:@"%d %@", distance, (distance == 1) ? NSLocalizedString(@"hour", @"") : NSLocalizedString(@"hours", @"")];
    } else if (distance < 60 * 60 * 24 * 7) {
        distance /= D_DAY;
        return [NSString stringWithFormat:@"%d %@", distance, (distance == 1) ? NSLocalizedString(@"day", @"") : NSLocalizedString(@"days", @"")];
    } else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance /= D_WEEK;
        return [NSString stringWithFormat:@"%d %@", distance, (distance == 1) ? NSLocalizedString(@"week", @"") : NSLocalizedString(@"weeks", @"")];
    } else {
        NSDateFormatter *dateFormatter = [NSDateFormatter make];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        return [dateFormatter stringFromDate:self];
    }
}

- (NSString *)stringUsingStyle:(NSDateFormatterStyle)style {
    return [self stringUsingStyle:style time:kCFDateFormatterNoStyle];
}

- (NSString *)stringUsingStyle:(NSDateFormatterStyle)style time:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *dateFormatter = [NSDateFormatter make];
    [dateFormatter setDateStyle:style];
    [dateFormatter setTimeStyle:timeStyle];
    return [dateFormatter stringFromDate:self];
}


@end
