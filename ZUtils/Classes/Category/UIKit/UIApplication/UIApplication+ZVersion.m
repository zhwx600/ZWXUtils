//
//  UIApplication+ZVersion.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIApplication+ZVersion.h"

#import <sys/utsname.h>
@implementation UIApplication (ZVersion)

+(NSString *)z_version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
+(NSInteger)z_build{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [app_build integerValue];
}
+(NSString *)z_identifier{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}
+(NSString *)z_currentLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages firstObject];
    return [NSString stringWithString:currentLanguage];
}
+(NSString *)z_deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [NSString stringWithString:deviceString];
}

+ (NSString *)z_appName
{
    NSDictionary *infoDictionary = [NSBundle mainBundle].localizedInfoDictionary ?: [NSBundle mainBundle].infoDictionary;
    // app名称
    NSString *app_Name = [infoDictionary valueForKey:@"CFBundleDisplayName"] ?: [infoDictionary valueForKey:@"CFBundleName"];
    
    return app_Name;
}

//是否是中文
+(BOOL)z_isCN
{
//#define ZLanguageChina @"zh-Hans"
//#define ZLanguageEn @"en"
    NSString* currLanguage = [self z_currentLanguage];
    if ([currLanguage hasPrefix:@"en"]) {
        return NO;
    }else if ([currLanguage hasPrefix:@"zh"]) {
        return YES;
    }else
        return NO;
}

@end
