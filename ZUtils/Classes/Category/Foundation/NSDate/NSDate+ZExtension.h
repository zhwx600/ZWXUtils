//
//  NSDate+ZExtension.h
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZExtension)
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)zz_day;
- (NSUInteger)zz_month;
- (NSUInteger)zz_year;
- (NSUInteger)zz_hour;
- (NSUInteger)zz_minute;
- (NSUInteger)zz_second;
+ (NSUInteger)z_day:(NSDate *)date;
+ (NSUInteger)z_month:(NSDate *)date;
+ (NSUInteger)z_year:(NSDate *)date;
+ (NSUInteger)z_hour:(NSDate *)date;
+ (NSUInteger)z_minute:(NSDate *)date;
+ (NSUInteger)z_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)z_daysInYear;
+ (NSUInteger)z_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)z_isLeapYear;
+ (BOOL)z_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)z_weekOfYear;
+ (NSUInteger)z_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)z_formatYMD;
+ (NSString *)z_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)z_weeksOfMonth;
+ (NSUInteger)z_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)z_begindayOfMonth;
+ (NSDate *)z_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)z_lastdayOfMonth;
+ (NSDate *)z_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)z_dateAfterDay:(NSUInteger)day;
+ (NSDate *)z_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)z_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)z_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)z_offsetYears:(int)numYears;
+ (NSDate *)z_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)z_offsetMonths:(int)numMonths;
+ (NSDate *)z_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)z_offsetDays:(int)numDays;
+ (NSDate *)z_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)z_offsetHours:(int)hours;
+ (NSDate *)z_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)z_daysAgo;
+ (NSUInteger)z_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)zz_weekday;
+ (NSInteger)z_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)z_dayFromWeekday;
+ (NSString *)z_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)z_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)zz_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)zz_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)z_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)z_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)z_stringWithFormat:(NSString *)format;
+ (NSDate *)z_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)z_daysInMonth:(NSUInteger)month;
+ (NSUInteger)z_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)z_daysInMonth;
+ (NSUInteger)z_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)z_timeInfo;
+ (NSString *)z_timeInfoWithDate:(NSDate *)date;
+ (NSString *)z_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)z_ymdFormat;
- (NSString *)z_hmsFormat;
- (NSString *)z_ymdHmsFormat;
+ (NSString *)z_ymdFormat;
+ (NSString *)z_hmsFormat;
+ (NSString *)z_ymdHmsFormat;

@end
