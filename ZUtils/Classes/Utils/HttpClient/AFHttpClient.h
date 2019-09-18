//
//  AFHttpClient.h
//  ZTemplate
//
//  Created by zwx on 2017/7/17.
//  Copyright © 2017年 zwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

//extern NSString* const kServerHost;
//extern NSString* const AFTempPathString;

#pragma mark-
//直接返回字典对象
typedef void(^AFSuccBlock)(id json);
typedef void(^AFFailBlock)(NSError *error);

@interface AFHttpClient : AFHTTPSessionManager

//在项目启动时，先设置 域名信息
+(void) setServerHost:(NSString*)host;//域名/ip地址
+(void) setServerTempPath:(NSString*)tPath;//接口地址 的通用路径。可不设置

//静态全局对象
+ (instancetype)sharedClient;


#pragma mark- 直接返回字典对象
// URLString 支持不带baseURL、temppath 和 支持全路径url
-(void) getUrl:(NSString*)URLString
         param:(NSDictionary*)param
       success:(AFSuccBlock)success
       failure:(AFFailBlock)failure
   processView:(UIView*)processView;

-(void) postUrl:(NSString*)URLString
          param:(NSDictionary*)param
        success:(AFSuccBlock)success
        failure:(AFFailBlock)failure
    processView:(UIView*)processView;

@end

