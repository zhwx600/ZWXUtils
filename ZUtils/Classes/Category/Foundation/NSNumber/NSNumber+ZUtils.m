//
//  NSNumber+ZUtils.m
//  TPMS
//
//  Created by zwx on 2017/10/30.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "NSNumber+ZUtils.h"

@implementation NSNumber (ZUtils)

/**
 固定保留2位小数，如:0=0.00，0.10=0.10，0.123=0.12
 */
-(NSString*) z_decimals2equal
{
    NSString* format = @"0.00";
    
    return [self numFormatter:format];
}

-(NSString*) z_decimals2equalSep
{
    NSString* format = @"#,##0.00";
    
    return [self numFormatter:format];
}


/**
 小于等于2位小数，如:0=0，0.10=0.1，0.123=0.12
 */
-(NSString*) z_decimals2less
{
    NSString* format = @"0.##";
    
    return [self numFormatter:format];
}

-(NSString*) z_decimals2lessSep
{
    NSString* format = @"#,##0.##";
    
    return [self numFormatter:format];
}

/**
 固定保留 n 位小数
 */
-(NSString*) z_decimalsNequal:(NSInteger)n
{
//    NSString* format = @"0.000000*n";
    NSString* format = @"0.";
    for (NSInteger i=0; i<n; i++) {
        format = [NSString stringWithFormat:@"%@0",format];
    }
    if (n <= 0) {
        format = @"0";
    }
    
    return [self numFormatter:format];
    
    
}

-(NSString*) z_decimalsNequalSep:(NSInteger)n
{
    NSString* format = @"#,##0.";
    for (NSInteger i=0; i<n; i++) {
        format = [NSString stringWithFormat:@"%@0",format];
    }
    if (n <= 0) {
        format = @"0";
    }
    
    return [self numFormatter:format];
    
    
}

/**
 小于等于 n 位小数
 */
-(NSString*) z_decimalsNless:(NSInteger)n
{
    //    NSString* format = @"0.######*n";
    NSString* format = @"0.";
    for (NSInteger i=0; i<n; i++) {
        format = [NSString stringWithFormat:@"%@#",format];
    }
    if (n <= 0) {
        format = @"0";
    }
    
    return [self numFormatter:format];
}

-(NSString*) z_decimalsNlessSep:(NSInteger)n
{
    //    NSString* format = @"0.######*n";
    NSString* format = @"#,##0.";
    for (NSInteger i=0; i<n; i++) {
        format = [NSString stringWithFormat:@"%@#",format];
    }
    if (n <= 0) {
        format = @"0";
    }
    
    return [self numFormatter:format];
}


//-(NSString*) numStr:(double)value
//{
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setPositiveFormat:@",##0.##"];
//    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
//    return formattedNumberString;
//}



-(NSString*) numFormatter:(NSString*)format
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:format];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:self];
    return formattedNumberString;
}


@end
