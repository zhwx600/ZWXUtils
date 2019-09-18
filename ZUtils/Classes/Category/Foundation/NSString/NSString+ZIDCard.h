//
//  NSString+ZIDCard.h
//  ZUtils
//
//  Created by zwx on 2018/2/27.
//

#import <Foundation/Foundation.h>


/**
 身份证 获取 年龄、性别
 */
@interface NSString (ZIDCard)

//年龄 18
+(NSString *) z_ageWithIDCard:(NSString *)IDCard;
//生日 1988-08-08
+(NSString *) z_birthdayWithIDCard:(NSString *)IDCard;
//性别 男、女
+(NSString *) z_sexWithIDCard:(NSString *)IDCard;


@end
