//
//  NSDate+PSFoundation.h
//  PSFoundation
//

@interface NSDate (PSFoundation)

/** A suite of creators and comparators for NSDate.
 
 This category introduces all manner of date initializers,
 comparisons, adjustments, intervals, and decompositions
 for NSDate instances on the minute, day, week, month,
 and year intervals.
 
 For the sake of simplicity rather than exactness, these
 methods use whole integer values rather than real
 numbers; fractions of intervals will not come into
 play. Instead, use the appropriate lesser interval.
 
 Includes code by the following:
 
 - [Erica Sadun](https://github.com/erica) - 2008. BSD.
 - [Peter Steinberger](https://github.com/steipete) - 2009. MIT.
 - [Matthias Tretter](https://github.com/myell0w) - 2010. MIT.
 - [Zach Waldowski](https://github.com/zwaldowski) - 2011. MIT.
 
 */

/** Creates and raturns an NSDate object with the date and time
 values specified by the given date components.
 
 @param components A set of date components.
 @return An NSDate object with a date and time value specified by components.
 */
+ (NSDate *)dateWithComponents:(NSDateComponents *)components;

/// ---------------------------------
/// @name Relative dates
/// ---------------------------------

/** Creates and returns a new date set to the time one minute from now.
 
 @return A new date object set one minute from now.
 */
+ (NSDate *)dateOneMinuteFromNow;

/** Creates and returns a new date set to the given time.

 @param dMinutes A whole number of minutes.
 @return A new date object set a number of minutes from now.
 */
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;

/** Creates and returns a new date set to the given time.
 
 @param dMinutes A whole number of minutes.
 @return A new date object set a number of minutes before now.
 */
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

/** Creates and returns a new date set to today at 00:00 in the local time zone.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateTodayMidnight;

/** Creates and returns a new date set to 24 hours before the current time.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateYesterday;

/** Creates and returns a new date set to tomorrow at 00:00.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateTomorrowMidnight;

/** Creates and returns a new date set to 24 hours after the current time.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateTomorrow;

/** Creates and returns a new date set to a multiple of 24 hours after the current time.
 
 @param days A whole number of days to add.
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;

/** Creates and returns a new date set to a multiple of 24 hours before the current time.
 
 @param days A whole number of days to subtract.
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;

/** Creates and returns a new date set to a number of hours after the current time.
 
 @param hours A whole number of hours to add.
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;

/** Creates and returns a new date set to a number of hours before the current time.
 
 @param hours A whole number of hours to subtract.
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;

/** Creates and returns a new date set to midnight on the first day of this week.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateThisWeek;

/** Creates and returns a new date set to midnight on the first day of last week.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateLastWeek;

/** Creates and returns a new date set to midnight on the first day of this month.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateThisMonth;

/** Creates and returns a new date set to midnight on the first day of last month.
 
 @return A new date object set to the specified date and time.
 */
+ (NSDate *)dateLastMonth;

/// ---------------------------------
/// @name Date comparisons
/// ---------------------------------

/** Compares two calendar dates without respect to their times.
 
 @param aDate A date to perform the comparison on.
 @return YES if the given date and the reciever fall on the same calendar day, NO otherwise.
 */
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;

/** Compares the calendar date of the reciever to the current day.
 
 @return YES if the reciever is the same day as today, NO otherwise.
 */
- (BOOL)isToday;

/** Compares the calendar date of the reciever to the next day.
 
 @return YES if the reciever is the same day as tomorrow, NO otherwise.
 */
- (BOOL)isTomorrow;

/** Compares the calendar date of the reciever to the previous day.
 
 @return YES if the reciever is the same day as yesterday, NO otherwise.
 */
- (BOOL)isYesterday;

/** Compares the week of the reciever to the given week.
 
 @param aDate A date to perform the comparison on.
 @return YES if the reciever is the same week as the given one, NO otherwise.
 */
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;

/** Compares the week of the reciever to the current week.
 
 @return YES if the reciever is the same week as the current one, NO otherwise.
 */
- (BOOL)isThisWeek;

/** Compares the week of the reciever to the next week.
 
 @return YES if the reciever is the same week as the next one, NO otherwise.
 */
- (BOOL)isNextWeek;

/** Compares the week of the reciever to the previous week.
 
 @return YES if the reciever is the same week as the previous one, NO otherwise.
 */
- (BOOL)isLastWeek;

/** Compares the year of the reciever to the given year.
 
 @param aDate A date to perform the comparison on.
 @return YES if the reciever is the same year as the given one, NO otherwise.
 */
- (BOOL)isSameYearAsDate:(NSDate *)aDate;

/** Compares the year of the reciever to the current year.
 
 @return YES if the reciever is the same year as this one, NO otherwise.
 */
- (BOOL)isThisYear;

/** Compares the year of the reciever to the next year.
 
 @return YES if the reciever is the same year as the next one, NO otherwise.
 */
- (BOOL)isNextYear;

/** Compares the year of the reciever to the last year.
 
 @return YES if the reciever is the same year as the previous one, NO otherwise.
 */
- (BOOL)isLastYear;

/** Compares the the given date and time with that of the reciever.
 
 @param aDate A date to perform the comparison on.
 @return YES if the reciever is in any way before the given one, NO otherwise.
 */
- (BOOL)isEarlier:(NSDate *)aDate;

/** Compares the the given date and time with that of the reciever.
 
 @param aDate A date to perform the comparison on.
 @return YES if the reciever is in any way after the given one, NO otherwise.
 */
- (BOOL)isLater:(NSDate *)aDate;

/// ---------------------------------
/// @name Relative date adjustments
/// ---------------------------------

/** Creates a new date by adding days.
 
 @param dDays The number of whole days to add.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateByAddingDays:(NSInteger)dDays;

/** Creates a new date by subtracting days.
 
 @param dDays The number of whole days to subtract.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;

/** Creates a new date by adding hours.
 
 @param dHours The number of whole hours to add.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateByAddingHours:(NSInteger)dHours;

/** Creates a new date by subtracting hours.
 
 @param dHours The number of whole hours to subtract.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;

/** Creates a new date by adding minutes.
 
 @param dMinutes The number of whole minutes to add.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;

/** Creates a new date by subtracting minutes.
 
 @param dMinutes The number of whole minutes to subtract.
 @return A new date object with the specified date and time.
 */
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;

/// ---------------------------------
/// @name Date comparison intervals
/// ---------------------------------

/** Compares the minutes between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole minutes between the reciever and the given date.
 */
- (NSInteger)minutesSinceDate:(NSDate *)aDate;

/** Compares the minutes between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole minutes between the given date and the reciever.
 */
- (NSInteger)minutesUntilDate:(NSDate *)aDate;

/** Compares the hours between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole hours between the reciever and the given date.
 */
- (NSInteger)hoursSinceDate:(NSDate *)aDate;

/** Compares the hours between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole hours between the given date and the reciever.
 */
- (NSInteger)hoursUntilDate:(NSDate *)aDate;

/** Compares the days between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole days between the reciever and the given date.
 */
- (NSInteger)daysSinceDate:(NSDate *)aDate;

/** Compares the days between two dates.

 @param aDate The date to perform the comparison on.
 @return The number of whole days between the given date and the reciever.
 */
- (NSInteger)daysUntilDate:(NSDate *)aDate;

/// ---------------------------------
/// @name Date decomposition
/// ---------------------------------

/** All components of a date according to the current calendar. */
@property (nonatomic, readonly) NSDateComponents *components;

/** The hour calculated by adding 30 minutes to the time and truncating. */
@property (readonly) NSInteger nearestHour;

/** The hour value of the date object. */
@property (readonly) NSInteger hour;

/** The minute value of the date object. */
@property (readonly) NSInteger minute;

/** The seconds value of the date object. */
@property (readonly) NSInteger seconds;

/** The calendar day value of the date object. */
@property (readonly) NSInteger day;

/** The month value of the date object. */
@property (readonly) NSInteger month;

/** The week value of the date object. */
@property (readonly) NSInteger week;

/** The weekday value of the date object. */
@property (readonly) NSInteger weekday;

/** The number ordinal of the weekday; e.g., a date with the 2nd Tuesday of the month will return 2. */
@property (readonly) NSInteger weekdayOrdinal; // e.g. 2nd Tuesday of the month == 2

/** The year value of the date object. */
@property (readonly) NSInteger year;

/// ---------------------------------
/// @name String conversion
/// ---------------------------------

/** Returns a user-friendly string representation of the date.

 This value is calculated from the current time using
 naturalDateWithReference.

 @see naturalDateWithReference:
 @return A string representation of the reciever.
 */
- (NSString *)naturalDate;

/** Returns a user-friendly string representation of the date.

 This value is calculated from the given time using the
 most significant date value up to 1 month, and will format
 it as NSDateFormatterShortStyle for any longer values.
 Intended for minute-by-minute times (e.g., Facebook status
 messages or tweets), such as "just now", "last week",
 "4 days".

 @see naturalDate
 @param reference A date by which to calculate the natural date.
 @return A string representation of the reciever.
 */
- (NSString *)naturalDateWithReference:(NSDate *)reference;

/** Returns a formatted string representation of the date.

 This is identical to formatting a date using NSDateFormatter,
 with no time formatting at all.

 @see stringUsingStyle:time:
 @param style A NSDateFormatterStyle constant for a calendar date.
 @return A string representation of the reciever.
 */
- (NSString *)stringUsingStyle:(NSDateFormatterStyle)style;

/** Returns a formatted string representation of the date.
 
 This is identical to formatting a date and time using
 using NSDateFormatter.
 
 @see stringUsingStyle:
 @param style A NSDateFormatterStyle constant for a calendar date.
 @param timeStyle A NSDateFormatterStyle constant for a time.
 @return A string representation of the reciever.
 */
- (NSString *)stringUsingStyle:(NSDateFormatterStyle)style time:(NSDateFormatterStyle)timeStyle;

@end
