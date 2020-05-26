//
//  NSDate+ZExtension.m
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import "NSDate+ZExtension.h"

@implementation NSDate (ZExtension)

- (NSUInteger)zz_day {
    return [NSDate z_day:self];
}

- (NSUInteger)zz_month {
    return [NSDate z_month:self];
}

- (NSUInteger)zz_year {
    return [NSDate z_year:self];
}

- (NSUInteger)zz_hour {
    return [NSDate z_hour:self];
}

- (NSUInteger)zz_minute {
    return [NSDate z_minute:self];
}

- (NSUInteger)zz_second {
    return [NSDate z_second:self];
}

+ (NSUInteger)z_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)z_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)z_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)z_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)z_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)z_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)z_daysInYear {
    return [NSDate z_daysInYear:self];
}

+ (NSUInteger)z_daysInYear:(NSDate *)date {
    return [self z_isLeapYear:date] ? 366 : 365;
}

- (BOOL)z_isLeapYear {
    return [NSDate z_isLeapYear:self];
}

+ (BOOL)z_isLeapYear:(NSDate *)date {
    NSUInteger year = [date zz_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)z_formatYMD {
    return [NSDate z_formatYMD:self];
}

+ (NSString *)z_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%zd-%zd-%zd",[date zz_year],[date zz_month], [date zz_day]];
}

- (NSUInteger)z_weeksOfMonth {
    return [NSDate z_weeksOfMonth:self];
}

+ (NSUInteger)z_weeksOfMonth:(NSDate *)date {
    return [[date z_lastdayOfMonth] z_weekOfYear] - [[date z_begindayOfMonth] z_weekOfYear] + 1;
}

- (NSUInteger)z_weekOfYear {
    return [NSDate z_weekOfYear:self];
}

+ (NSUInteger)z_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date zz_year];
    
    NSDate *lastdate = [date z_lastdayOfMonth];
    
    for (i = 1;[[lastdate z_dateAfterDay:-7 * i] zz_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)z_dateAfterDay:(NSUInteger)day {
    return [NSDate z_dateAfterDate:self day:day];
}

+ (NSDate *)z_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)z_dateAfterMonth:(NSUInteger)month {
    return [NSDate z_dateAfterDate:self month:month];
}

+ (NSDate *)z_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)z_begindayOfMonth {
    return [NSDate z_begindayOfMonth:self];
}

+ (NSDate *)z_begindayOfMonth:(NSDate *)date {
    return [self z_dateAfterDate:date day:-[date zz_day] + 1];
}

- (NSDate *)z_lastdayOfMonth {
    return [NSDate z_lastdayOfMonth:self];
}

+ (NSDate *)z_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self z_begindayOfMonth:date];
    return [[lastDate z_dateAfterMonth:1] z_dateAfterDay:-1];
}

- (NSUInteger)z_daysAgo {
    return [NSDate z_daysAgo:self];
}

+ (NSUInteger)z_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)zz_weekday {
    return [NSDate z_weekday:self];
}

+ (NSInteger)z_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)z_dayFromWeekday {
    return [NSDate z_dayFromWeekday:self];
}

+ (NSString *)z_dayFromWeekday:(NSDate *)date {
    switch([date zz_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)z_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)zz_isToday {
    return [self z_isSameDay:[NSDate date]];
}

- (NSDate *)zz_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)z_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)z_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date z_stringWithFormat:format];
}

- (NSString *)z_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)z_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)z_daysInMonth:(NSUInteger)month {
    return [NSDate z_daysInMonth:self month:month];
}

+ (NSUInteger)z_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date z_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)z_daysInMonth {
    return [NSDate z_daysInMonth:self];
}

+ (NSUInteger)z_daysInMonth:(NSDate *)date {
    return [self z_daysInMonth:date month:[date zz_month]];
}

- (NSString *)z_timeInfo {
    return [NSDate z_timeInfoWithDate:self];
}

+ (NSString *)z_timeInfoWithDate:(NSDate *)date {
    return [self z_timeInfoWithDateString:[self z_stringWithDate:date format:[self z_ymdHmsFormat]]];
}

+ (NSString *)z_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self z_dateWithString:dateString format:[self z_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
//    int month = (int)([curDate z_month] - [date z_month]);
    int year = (int)([curDate zz_year] - [date zz_year]);
//    int day = (int)([curDate z_day] - [date z_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        //        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
        return retTime < 1.0 ? @"刚刚" : [NSString stringWithFormat:@"%.0f分钟前", retTime];
        
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }else if(year == 0){
        return [date z_stringWithFormat:@"MM-dd"];
    }else{
        return [date z_stringWithFormat:@"yyyy-MM-dd"];
    }
//    // 第一个条件是同年，且相隔时间在一个月内
//    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
//    else if ((abs(year) == 0 && abs(month) <= 1)
//             || (abs(year) == 1 && [curDate z_month] == 1 && [date z_month] == 12)) {
//        int retDay = 0;
//        if (year == 0) { // 同年
//            if (month == 0) { // 同月
//                retDay = day;
//            }
//        }
//
//        if (retDay <= 0) {
//            // 获取发布日期中，该月有多少天
//            int totalDays = (int)[self z_daysInMonth:date month:[date z_month]];
//
//            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
//            retDay = (int)[curDate z_day] + (totalDays - (int)[date z_day]);
//        }
//
//        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
//    } else  {
//        if (abs(year) <= 1) {
//            if (year == 0) { // 同年
//                return [NSString stringWithFormat:@"%d个月前", abs(month)];
//            }
//
//            // 隔年
//            int month = (int)[curDate z_month];
//            int preMonth = (int)[date z_month];
//            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
//                return @"1年前";
//            }
//            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
//        }
//
//        return [NSString stringWithFormat:@"%d年前", abs(year)];
//    }
    
    return @"1小时前";
}

- (NSString *)z_ymdFormat {
    return [NSDate z_ymdFormat];
}

- (NSString *)z_hmsFormat {
    return [NSDate z_hmsFormat];
}

- (NSString *)z_ymdHmsFormat {
    return [NSDate z_ymdHmsFormat];
}

+ (NSString *)z_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)z_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)z_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self z_ymdFormat], [self z_hmsFormat]];
}

- (NSDate *)z_offsetYears:(int)numYears {
    return [NSDate z_offsetYears:numYears fromDate:self];
}

+ (NSDate *)z_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)z_offsetMonths:(int)numMonths {
    return [NSDate z_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)z_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)z_offsetDays:(int)numDays {
    return [NSDate z_offsetDays:numDays fromDate:self];
}

+ (NSDate *)z_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)z_offsetHours:(int)hours {
    return [NSDate z_offsetHours:hours fromDate:self];
}

+ (NSDate *)z_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}
@end

