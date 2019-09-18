//
//  ZLanguage.m
//  TPMS
//
//  Created by zwx on 2017/11/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZLanguage.h"

#define LocalLanguageKey @"LocalLanguageKey"


@implementation ZLanguage

static NSBundle *bundle = nil;
+ ( NSBundle * )bundle{
    
    if (!bundle) {
        [self initUserLanguage];
    }
    
    return bundle;
}

//首次加载的时候先检测语言是否存在
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *currLanguage = [def valueForKey:LocalLanguageKey];
    
    if(!currLanguage){
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        currLanguage = preferredLanguages[0];
        if ([currLanguage hasPrefix:@"en"]) {
            currLanguage = @"en";
        }else if ([currLanguage hasPrefix:@"zh"]) {
            currLanguage = @"zh-Hans";
        }else currLanguage = @"en";
        [def setValue:currLanguage forKey:LocalLanguageKey];
        [def synchronize];
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

//获取当前语言
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:LocalLanguageKey];
    
    if (language.length <= 0) {
        [self initUserLanguage];
        language = [def valueForKey:LocalLanguageKey];
    }
    
    if (!bundle) {
        //获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        bundle = [NSBundle bundleWithPath:path];//生成bundle
    }
    
    
    return language;
}
//设置语言
+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currLanguage = [userDefaults valueForKey:LocalLanguageKey];
    if ([currLanguage isEqualToString:language]) {
        return;
    }
    [userDefaults setValue:language forKey:LocalLanguageKey];
    [userDefaults synchronize];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    
}

//是否是中文
+(BOOL)isCN
{
    //#define ZLanguageChina @"zh-Hans"
    //#define ZLanguageEn @"en"
    NSString* currLanguage = [self userLanguage];
    if ([currLanguage hasPrefix:ZLanguageEn]) {
        return NO;
    }else if ([currLanguage hasPrefix:ZLanguageChina]) {
        return YES;
    }else
        return NO;
}

#pragma mark-

//获取 手机系统的语言
+(NSString *)systemLanguage
{
    NSArray *preferredLanguages = [NSLocale preferredLanguages];
    NSString* currLanguage = preferredLanguages[0];
    if ([currLanguage hasPrefix:@"en"]) {
        currLanguage = @"en";
    }else if ([currLanguage hasPrefix:@"zh"]) {
        currLanguage = @"zh-Hans";
    }else currLanguage = @"en";
    
    return currLanguage;
}

//调用此方法 语言会随着手机系统语言切换而改变
+(void) initSysModel
{
    [self setUserlanguage:[self systemLanguage]];
}

@end

