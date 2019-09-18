//
//  NSString+ZIDCard.m
//  ZUtils
//
//  Created by zwx on 2018/2/27.
//

#import "NSString+ZIDCard.h"

@implementation NSString (ZIDCard)

//年龄 18
+(NSString *) z_ageWithIDCard:(NSString *)IDCard
{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *bsyDate = [formatterTow dateFromString:[self z_birthdayWithIDCard:IDCard]];
    
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    
    return [NSString stringWithFormat:@"%d",-age];
}
//生日 1988-08-08
+(NSString *) z_birthdayWithIDCard:(NSString *)IDCard
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([IDCard length]<18)
        
        return result;
    //**从第6位开始 截取8个数
    
    NSString *fontNumer = [IDCard substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    
    while (*p!='\0') {
        
        if(!(*p>='0'&&*p<='9'))
            
            isAllNumber = NO;
        p++;
    }
    
    if(!isAllNumber)
        return result;
    year = [NSString stringWithFormat:@"19%@",[IDCard substringWithRange:NSMakeRange(8, 2)]];
    
    //    NSLog(@"year ==%@",year);
    month = [IDCard substringWithRange:NSMakeRange(10, 2)];
    
    //    NSLog(@"month ==%@",month);
    day = [IDCard substringWithRange:NSMakeRange(12,2)];
    
    //    NSLog(@"day==%@",day);
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    //    NSLog(@"result===%@",result);
    
    return result;
    
}
//性别 男、女
+(NSString *) z_sexWithIDCard:(NSString *)IDCard
{
    NSString *sex = @"";
    //获取18位 二代身份证  性别
    if (IDCard.length==18)
    {
        int sexInt=[[IDCard substringWithRange:NSMakeRange(16,1)] intValue];
        if(sexInt%2!=0)
        {
            NSLog(@"1");
            sex = @"男";
        }
        else
        {
            NSLog(@"2");
            sex = @"女";
        }
    }
    
    //  获取15位 一代身份证  性别
    if (IDCard.length==15)
    {
        int sexInt=[[IDCard substringWithRange:NSMakeRange(14,1)] intValue];
        if(sexInt%2!=0)
        {
            NSLog(@"1");
            sex = @"男";
        }
        else
        {
            NSLog(@"2");
            sex = @"女";
        }
    }
    
    return sex;
}

@end
