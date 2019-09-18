//
//  NSDate+ZCupertinoYankee.h
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZCupertinoYankee)

- (NSDate *)z_beginningOfDay;
- (NSDate *)z_endOfDay;

- (NSDate *)z_beginningOfWeek;
- (NSDate *)z_endOfWeek;

- (NSDate *)z_beginningOfMonth;
- (NSDate *)z_endOfMonth;

- (NSDate *)z_beginningOfYear;
- (NSDate *)z_endOfYear;

@end
