//
//  TimeFormatters.h
//  PSFoundation
//
//  Created by Dustin Voss.
//  Licensed under BSD.  All rights reserved.
//

typedef enum IntervalFormatterStyle {
    kIntervalFormatterDecimalStyle,
    kIntervalFormatterShortStyle,
    kIntervalFormatterMediumStyle,
    kIntervalFormatterAbbrLongStyle,
    kIntervalFormatterLongStyle
} IntervalFormatterStyle;


@interface IntervalFormatter : NSFormatter
@property (nonatomic, assign) IntervalFormatterStyle style;
@end


@interface DateComponentsFormatter : NSFormatter
@property (nonatomic, retain) NSDateFormatter *formatter;
@property (nonatomic, assign) NSDateFormatterStyle dateStyle;
@property (nonatomic, assign) NSDateFormatterStyle timeStyle;
@end


@interface IntervalComponentsFormatter : NSFormatter
@property (nonatomic, assign) IntervalFormatterStyle style;
@end


@interface MinutesFormatter : NSFormatter
@property (nonatomic, assign) IntervalFormatterStyle style;
@end


@interface HoursFormatter : NSFormatter
@property (nonatomic, assign) IntervalFormatterStyle style;
@end


@interface DaysFormatter : NSFormatter
@property (nonatomic, assign) IntervalFormatterStyle style;
@end