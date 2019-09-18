//
//  UIApplication+ZVersion.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ZVersion)

//主版本号
+(NSString *)z_version;
//编译版本号
+(NSInteger)z_build;
//appid
+(NSString *)z_identifier;
//当前语言
+(NSString *)z_currentLanguage;
//设备名字
+(NSString *)z_deviceModel;
//app显示名称
+(NSString *)z_appName;

//是否是中文
+(BOOL)z_isCN;
@end
