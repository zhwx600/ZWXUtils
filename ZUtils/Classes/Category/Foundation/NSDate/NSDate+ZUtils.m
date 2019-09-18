//
//  NSDate+ZUtils.m
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import "NSDate+ZUtils.h"
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#define z_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({ \
unsigned components;\
if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
}else{ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
} \
components; \
})\
_Pragma("clang diagnostic pop") \

#else
#define z_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({\
unsigned components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
components; \
})\
_Pragma("clang diagnostic pop") \

#endif

@implementation NSDate (ZUtils)


+ (NSCalendar *) z_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *)z_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] z_dateByAddingDays:days];
}

+ (NSDate *)z_dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] z_dateBySubtractingDays:days];
}

+ (NSDate *) z_dateTomorrow
{
    return [NSDate z_dateWithDaysFromNow:1];
}

+ (NSDate *) z_dateYesterday
{
    return [NSDate z_dateWithDaysBeforeNow:1];
}

+ (NSDate *) z_dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + z_D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) z_dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - z_D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) z_dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + z_D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) z_dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - z_D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties
- (NSString *) z_stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) z_stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) z_shortString
{
    return [self z_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) z_shortTimeString
{
    return [self z_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) z_shortDateString
{
    return [self z_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) z_mediumString
{
    return [self z_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) z_mediumTimeString
{
    return [self z_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) z_mediumDateString
{
    return [self z_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) z_longString
{
    return [self z_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) z_longTimeString
{
    return [self z_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) z_longDateString
{
    return [self z_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) z_isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) z_isToday
{
    return [self z_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) z_isTomorrow
{
    return [self z_isEqualToDateIgnoringTime:[NSDate z_dateTomorrow]];
}

- (BOOL) z_isYesterday
{
    return [self z_isEqualToDateIgnoringTime:[NSDate z_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)z_isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < z_D_WEEK);
    
}

- (BOOL) z_isThisWeek
{
    return [self z_isSameWeekAsDate:[NSDate date]];
}

- (BOOL) z_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + z_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self z_isSameWeekAsDate:newDate];
}

- (BOOL) z_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - z_D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self z_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) z_isSameMonthAsDate: (NSDate *) aDate
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#endif
    
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) z_isThisMonth
{
    return [self z_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) z_isLastMonth
{
    return [self z_isSameMonthAsDate:[[NSDate date] z_dateBySubtractingMonths:1]];
}

- (BOOL) z_isNextMonth
{
    return [self z_isSameMonthAsDate:[[NSDate date] z_dateByAddingMonths:1]];
}

- (BOOL) z_isSameYearAsDate: (NSDate *) aDate
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit  fromDate:aDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#endif
    return (components1.year == components2.year);
}

- (BOOL) z_isThisYear
{
    // Thanks, baspellis
    return [self z_isSameYearAsDate:[NSDate date]];
}

- (BOOL) z_isNextYear
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) z_isLastYear
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self];
        components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
#endif
    return (components1.year == (components2.year - 1));
}

- (BOOL) z_isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) z_isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) z_isInFuture
{
    return ([self z_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) z_isInPast
{
    return ([self z_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) z_isTypicallyWeekend
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate z_currentCalendar] components:NSCalendarUnitWeekday | NSCalendarUnitMonth fromDate:self];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate z_currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate z_currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
#endif
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) z_isTypicallyWorkday
{
    return ![self z_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) z_dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) z_dateBySubtractingYears: (NSInteger) dYears
{
    return [self z_dateByAddingYears:-dYears];
}

- (NSDate *) z_dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) z_dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self z_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) z_dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) z_dateBySubtractingDays: (NSInteger) dDays
{
    return [self z_dateByAddingDays: (dDays * -1)];
}

- (NSDate *) z_dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + z_D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) z_dateBySubtractingHours: (NSInteger) dHours
{
    return [self z_dateByAddingHours: (dHours * -1)];
}

- (NSDate *) z_dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + z_D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) z_dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self z_dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) z_componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

- (NSDate *) z_dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate z_currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) z_dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate z_currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) z_minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / z_D_MINUTE);
}

- (NSInteger) z_minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / z_D_MINUTE);
}

- (NSInteger) z_hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / z_D_HOUR);
}

- (NSInteger) z_hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / z_D_HOUR);
}

- (NSInteger) z_daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / z_D_DAY);
}

- (NSInteger) z_daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / z_D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)z_distanceDaysToDate:(NSDate *)anotherDate
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate z_currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate z_currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate z_currentCalendar] components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    
    return components.day;
}
- (NSInteger)z_distanceMonthsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate z_currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate z_currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate z_currentCalendar] components:NSMonthCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.month;
}
- (NSInteger)z_distanceYearsToDate:(NSDate *)anotherDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate z_currentCalendar] components:NSCalendarUnitYear fromDate:self toDate:anotherDate options:0];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components = [[NSDate z_currentCalendar] components:NSYearCalendarUnit fromDate:self toDate:anotherDate options:0]
#endif
    return components.year;
}
#pragma mark Decomposing Dates
- (NSInteger)z_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + z_D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate z_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate z_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components =  [[NSDate z_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#endif
    return components.hour;
}
- (NSInteger) z_hour
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.hour;
}

- (NSInteger) z_minute
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.minute;
}

- (NSInteger) z_seconds
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.second;
}

- (NSInteger) z_day
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.day;
}

- (NSInteger) z_month
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.month;
}

- (NSInteger) z_week
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) z_weekday
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekday;
}

- (NSInteger) z_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) z_year
{
    NSDateComponents *components = [[NSDate z_currentCalendar] components:z_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.year;
}





#pragma mark ---- 时间戳转 NSDate

/**
 * 根据时间戳转日期 (秒)
 */
+ (NSDate *) z_dateWithSecond:(NSInteger)second
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:second];
    return confromTimesp;
}
/**
 * 根据长时间戳转日期  （毫秒）
 */
+ (NSDate *) z_dateWithMilliSecond:(long long)milsecond
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:milsecond/1000];
    return confromTimesp;
}

#pragma mark ---- 剩余时间计算
/**
 * 根据描述时间转日期（format:yyyy-MM-dd HH:mm:ss）
 */
+ (NSDate *)z_dateFromeString:(NSString *)dateString{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateString];
}

/**
 * nsdate to nsstring
 */
+(NSString*) z_stringWithFromat:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

/*
 A. 显示的时间是当天
 那么显示消息发布的时间，以“时:分”的格式显示
 B. 显示的时间是昨天
 那么显示消息发布的时间，以“昨天 时:分”的格式显示
 C. 显示的时间是昨天之前，且是当年
 那么显示消息发布的日期，以“月-日”的格式显示
 D. 显示的时间不是当年
 那么显示消息发布的年月日，以“年-月-日”的格式显示
 */
+ (NSString *)z_timeAgoWithDate:(NSDate *)date
{
    NSDate* nowDate = [NSDate date];
    
    //计算今天的起点时间
    NSDate* startTodayDate = [self z_dateFromeString:[self z_stringWithFromat:@"yyyy-MM-dd 00:00:00" date:nowDate]];
    
    //计算昨天的起点时间
    NSDate* yesterday = [NSDate dateWithTimeInterval:(-24*60*60.0) sinceDate:nowDate];
    NSDate* startYesterdayDate = [self z_dateFromeString:[self z_stringWithFromat:@"yyyy-MM-dd 00:00:00" date:yesterday]];
    
    //计算今年的起点时间
    NSDate* startThisYearDate = [self z_dateFromeString:[self z_stringWithFromat:@"yyyy-01-01 00:00:00" date:nowDate]];
    
    //计算 【date 和 今天、昨天、今年的起点】 时间间隔
    NSTimeInterval todayDistanceValue = [date timeIntervalSinceDate:startTodayDate];
    NSTimeInterval yesterdayDistanceValue = [date timeIntervalSinceDate:startYesterdayDate];
    NSTimeInterval thisYearDistanceValue = [date timeIntervalSinceDate:startThisYearDate];
    
    if (todayDistanceValue >= 0) {
        return [self z_stringWithFromat:@"HH:mm" date:date];
    }else if (yesterdayDistanceValue >= 0){
        return [NSString stringWithFormat:@"昨天 %@",[self z_stringWithFromat:@"HH:mm" date:date]];
    }else if (thisYearDistanceValue >= 0){
        return [self z_stringWithFromat:@"MM-dd" date:date];
    }else{
        return [self z_stringWithFromat:@"yyyy-MM-dd" date:date];
    }
    
}


/* 剩余时间
 
 1. 如剩余时大于或等于1天，那么展示剩余X天，X为实际天数的向下取整，如25小时，那么显示：剩余1天，50小时显示剩余2天
 2. 如剩余时间小于1天且大于或等于1小时，那么展示剩余Y小时，Y为实际小时数的向下取整，如150分种，那么显示：剩余2小时
 3. 如剩余时间小于1小时且大于或等于1分钟，那么展示剩余Z分钟，Z为实际分钟数的向下取整，如150秒，那么显示剩余2分钟。
 4. 如小于60秒，那么显示“即将过期”
 */
+ (NSString *)z_remainingTimeWithServiceDate:(NSDate *)date endDate:(NSDate *)endDate{
    
    if (!date || !endDate)
        return nil;
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算2个时间的差值
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:date toDate:endDate options:0];
    
    if (dateComponents.day > 0) {
        return [NSString stringWithFormat:@"剩余%ld天",dateComponents.day];
        
    }else if (dateComponents.hour > 0){
        
        return [NSString stringWithFormat:@"剩余%ld小时",dateComponents.hour];
        
    }else if (dateComponents.minute > 0){
        
        return [NSString stringWithFormat:@"剩余%ld分钟",dateComponents.minute];
        
    }else if (dateComponents.second > 0){
        
        return @"即将过期";
        
    }
    else {
        return nil;
    }
    

}

/* 剩余时间
 * 格式：x天x时x分x秒
 */
+ (NSString *)z_longRemainingTimeWithServiceDate:(NSDate *)date endDate:(NSDate *)endDate{
    
    if (!date || !endDate || [date timeIntervalSince1970]==0 || [endDate timeIntervalSince1970]==0)
        return nil;
    
    NSMutableString * remainingStr = [NSMutableString string];
    
    
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算2个时间的差值
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:date toDate:endDate options:0];
    
    if (dateComponents.day>0) {
        [remainingStr appendFormat:@"%ld天",dateComponents.day];
    }
    if (dateComponents.hour>0) {
        [remainingStr appendFormat:@"%ld时",dateComponents.hour];
    }
    if (dateComponents.minute>0) {
        [remainingStr appendFormat:@"%ld分",dateComponents.minute];
    }
    if (dateComponents.second>0) {
        [remainingStr appendFormat:@"%ld秒",dateComponents.second];
    }
    return remainingStr;
}

@end
