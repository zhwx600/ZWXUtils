//
//  NSDate+ZUtils.h
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import <Foundation/Foundation.h>

#define z_D_MINUTE    60
#define z_D_HOUR    3600
#define z_D_DAY    86400
#define z_D_WEEK    604800
#define z_D_YEAR    31556926
@interface NSDate (ZUtils)
+ (NSCalendar *)z_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger z_nearestHour;
@property (readonly) NSInteger z_hour;
@property (readonly) NSInteger z_minute;
@property (readonly) NSInteger z_seconds;
@property (readonly) NSInteger z_day;
@property (readonly) NSInteger z_month;
@property (readonly) NSInteger z_week;
@property (readonly) NSInteger z_weekday;
@property (readonly) NSInteger z_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger z_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *z_shortString;
@property (nonatomic, readonly) NSString *z_shortDateString;
@property (nonatomic, readonly) NSString *z_shortTimeString;
@property (nonatomic, readonly) NSString *z_mediumString;
@property (nonatomic, readonly) NSString *z_mediumDateString;
@property (nonatomic, readonly) NSString *z_mediumTimeString;
@property (nonatomic, readonly) NSString *z_longString;
@property (nonatomic, readonly) NSString *z_longDateString;
@property (nonatomic, readonly) NSString *z_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)z_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)zz_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)z_dateTomorrow;
///昨天
+ (NSDate *)z_dateYesterday;
///今天后几天
+ (NSDate *)z_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)z_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)z_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)z_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)z_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)z_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)z_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)z_isToday;
///是否是明天
- (BOOL)z_isTomorrow;
///是否是昨天
- (BOOL)z_isYesterday;

///是否是同一周
- (BOOL)z_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)z_isThisWeek;
///是否是本周的下周
- (BOOL)z_isNextWeek;
///是否是本周的上周
- (BOOL)z_isLastWeek;

///是否是同一月
- (BOOL)z_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)z_isThisMonth;
///是否是本月的下月
- (BOOL)z_isNextMonth;
///是否是本月的上月
- (BOOL)z_isLastMonth;

///是否是同一年
- (BOOL)z_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)z_isThisYear;
///是否是今年的下一年
- (BOOL)z_isNextYear;
///是否是今年的上一年
- (BOOL)z_isLastYear;

///是否提前aDate
- (BOOL)z_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)z_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)z_isInFuture;
///是否晚是过去
- (BOOL)z_isInPast;


///是否是工作日
- (BOOL)z_isTypicallyWorkday;
///是否是周末
- (BOOL)z_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)z_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)z_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)z_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)z_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)z_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)z_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)z_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)z_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)z_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)z_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)z_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)z_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)z_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)z_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)z_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)z_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)z_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)z_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)z_distanceYearsToDate:(NSDate *)anotherDate;


#pragma mark ---- 时间戳转 NSDate
/**
 * 根据时间戳转日期 (秒)
 */
+ (NSDate *) z_dateWithSecond:(NSInteger)second;
/**
 * 根据长时间戳转日期  （毫秒）
 */
+ (NSDate *) z_dateWithMilliSecond:(long long)milsecond;


#pragma mark ---- 剩余时间计算
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
+ (NSString *) z_timeAgoWithDate:(NSDate *)date;

/* 剩余时间
 
 1. 如剩余时大于或等于1天，那么展示剩余X天，X为实际天数的向下取整，如25小时，那么显示：剩余1天，50小时显示剩余2天
 2. 如剩余时间小于1天且大于或等于1小时，那么展示剩余Y小时，Y为实际小时数的向下取整，如150分种，那么显示：剩余2小时
 3. 如剩余时间小于1小时且大于或等于1分钟，那么展示剩余Z分钟，Z为实际分钟数的向下取整，如150秒，那么显示剩余2分钟。
 4. 如小于60秒，那么显示“即将过期”
 */
+ (NSString *) z_remainingTimeWithServiceDate:(NSDate *)date endDate:(NSDate *)endDate;

/* 剩余时间
 * 格式：x天x时x分x秒
 */
+ (NSString *) z_longRemainingTimeWithServiceDate:(NSDate *)date endDate:(NSDate *)endDate;

@end
