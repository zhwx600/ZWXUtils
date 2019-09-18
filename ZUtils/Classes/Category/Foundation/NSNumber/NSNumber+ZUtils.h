//
//  NSNumber+ZUtils.h
//  TPMS
//
//  Created by zwx on 2017/10/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (ZUtils)

/**
 固定保留2位小数，如:0=0.00，0.10=0.10，0.123=0.12
 */
-(NSString*) z_decimals2equal;
-(NSString*) z_decimals2equalSep;//带 ，分隔符

/**
 小于等于2位小数，如:0=0，0.10=0.1，0.123=0.12
 */
-(NSString*) z_decimals2less;
-(NSString*) z_decimals2lessSep;

/**
 固定保留 n 位小数
 */
-(NSString*) z_decimalsNequal:(NSInteger)n;
-(NSString*) z_decimalsNequalSep:(NSInteger)n;

/**
 小于等于 n 位小数
 */
-(NSString*) z_decimalsNless:(NSInteger)n;
-(NSString*) z_decimalsNlessSep:(NSInteger)n;

@end
