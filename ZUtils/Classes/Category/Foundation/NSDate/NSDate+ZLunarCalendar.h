//
//  NSDate+ZLunarCalendar.h
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import <Foundation/Foundation.h>

/**
 农历大写日期
 */
@interface NSDate (ZLunarCalendar)
+ (NSCalendar *)z_chineseCalendar;
//例如 五月初一
+ (NSString*)z_currentMDDateString;
//例如 乙未年五月初一
+ (NSString*)z_currentYMDDateString;
//例如 星期一
+ (NSString *)z_currentWeek:(NSDate*)date;
//例如 星期一
+ (NSString *)z_currentWeekWithDateString:(NSString*)datestring;
//例如 五月一
+ (NSString*)z_currentCapitalDateString;
@end
