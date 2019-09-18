//
//  ZLanguage.h
//  TPMS
//
//  Created by zwx on 2017/11/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//系统自动切换语言方法。
//#define ZLStr_K(key) NSLocalizedString((key)), nil)
//#define ZLStr_KT(key,tbl) NSLocalizedStringFromTable((key), (tbl), nil)

//Localizable.strings  文件
#define ZLStr_K(key) [[ZLanguage bundle] localizedStringForKey:(key) value:nil table:nil]
//自定义 tbl.strings 文件
#define ZLStr_KT(key,tbl) [[ZLanguage bundle] localizedStringForKey:(key) value:nil table:(tbl)]



#define ZLanguageChina @"zh-Hans"
#define ZLanguageEn @"en"



/**
 多语言版本 切换工具。 支持 中、英文2种版本，再多语言需要改造下。
 
 该类 用于手动修改中英文版本(微信) 使用，如果要使他 随手机语言切换而手机语言跟着切换，则在启动app时如下调用：
 
 [ZLanguage initSysModel];
 
 */
@interface ZLanguage : NSObject

+(void)initUserLanguage;//初始化本地语言资源 到 userdefault

+(NSBundle *)bundle;//获取当前语言资源文件
+(NSString *)userLanguage;//获取应用当前设置的语言
+(void)setUserlanguage:(NSString *)language;//切换语言
+(BOOL) isCN;//判断当前是否是中文


#pragma mark-

//获取 手机系统的语言
+(NSString *)systemLanguage;
//调用此方法 语言会随着手机系统语言切换而改变
+(void) initSysModel;

@end

