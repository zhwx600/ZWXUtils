//
//  AFHttpClient.m
//  ZTemplate
//
//  Created by zwx on 2017/7/17.
//  Copyright © 2017年 zwx. All rights reserved.
//

#import "AFHttpClient.h"
#import "MBProgressHUD.h"
#import "ZProgressHUD.h"



//服务器地址的设置
static NSString* kServerHost = @"";
static NSString* kServerTempPath = @"";//中间路径


NSInteger  const gHttpTimeoutInterval = 20;

#define REQUEST_METHOD_GET @"GET"
#define REQUEST_METHOD_POST @"POST"


@implementation AFHttpClient
+ (instancetype)sharedClient {
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kServerHost]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        //json 提交
        _sharedClient.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        _sharedClient.requestSerializer.timeoutInterval = gHttpTimeoutInterval;
        
        ((AFJSONResponseSerializer*)_sharedClient.responseSerializer).removesKeysWithNullValues = YES;
        ((AFJSONResponseSerializer*)_sharedClient.responseSerializer).acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        //        _sharedClient.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    });
    
    return _sharedClient;
}


//在项目启动时，先设置 域名信息
+(void) setServerHost:(NSString*)host//域名/ip地址
{
    kServerHost = host;
}
+(void) setServerTempPath:(NSString*)tPath//接口地址 的通用路径。可不设置
{
    kServerTempPath = tPath;
}


/**
 * 获取MBProgressHUD用于显示加载提示
 */
- (MBProgressHUD *) getMBProgressHUDWithView:(UIView*)fView
{
    if (!fView) {
        return nil;
    }
    MBProgressHUD* processHud = [[MBProgressHUD alloc] initWithView:fView];
    processHud.label.text = nil;
    processHud.mode = MBProgressHUDModeIndeterminate;
    processHud.delegate = nil;
    processHud.removeFromSuperViewOnHide = YES;
    
    processHud.bezelView.color = [UIColor blackColor];
    processHud.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    
    [fView addSubview:processHud];
    //    [fView bringSubviewToFront:processHud];
    
    return processHud;
}


#pragma mark- 直接返回字段对象的 请求方式
-(void) requestUrl:(nullable NSString*)URLString
         param:(nullable NSDictionary*)param
       success:(nullable AFSuccBlock)success
       failure:(nullable AFFailBlock)failure
   processView:(nullable UIView*)processView
        method:(nullable NSString*)method
{
    __block NSString* newUrlStr = URLString;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
        newUrlStr = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
#else
        newUrlStr = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#endif
        //中间临时路径 的 添加
        if (![newUrlStr hasPrefix:@"http"] && kServerTempPath.length>0) {
            newUrlStr = [kServerTempPath stringByAppendingPathComponent:URLString];
        }
        
        //菊花
        __block MBProgressHUD* processHUD = nil;
        if (processView) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                processHUD = [self getMBProgressHUDWithView:processView];
                [processHUD showAnimated:YES];
            });
        }
        
        //设置http 头部
//        if ([GlobalData shared].o_memberInfo.token.length > 0) {
//            NSString* nToken = [NSString stringWithFormat:@"Bearer %@",[GlobalData shared].o_memberInfo.token];
//            [self.requestSerializer setValue:nToken forHTTPHeaderField:@"Authorization"];
//        }
        
        //计算全路径
        NSString* fullUrlStr = newUrlStr;
        if ([newUrlStr hasPrefix:@"http"]) {
            fullUrlStr = newUrlStr;
        }else{
            fullUrlStr = [[NSURL URLWithString:newUrlStr relativeToURL:self.baseURL] absoluteString];
        }
        
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:fullUrlStr parameters:param error:nil];
        
        request.timeoutInterval = self.requestSerializer.timeoutInterval;
        if ([method isEqualToString:REQUEST_METHOD_GET]) {
            NSLog(@"\n*************************GET URL*************************\n%@",request.URL);
        }else if ([method isEqualToString:REQUEST_METHOD_POST]){
            NSLog(@"\n*************************POST URL*************************\n%@\nParam:\n%@",request.URL,param);
        }else{
            NSLog(@"\n*************************XXXX URL*************************\n%@\nParam:\n%@",request.URL,param);
        }
        
        __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
            
            if (processView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [processHUD hideAnimated:YES];
                });
            }
            
            //自定义修改
            NSHTTPURLResponse* hresponse = (NSHTTPURLResponse*)response;
            
            if (error || hresponse.statusCode != 200) {
                
                NSLog(@"\n------------------------Error Json Url------------------------\n%@\nResult:\n%@\nDescription:\n%@\nstatusCode:\n%ld\nError:\n%@\n",request.URL,responseObject,hresponse.debugDescription,(long)hresponse.statusCode,[error description]);
                
                NSString* tipMsg = @"网络请求失败";
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ZProgressHUD makeToast:tipMsg];
                    if (failure) {
                        failure(error);
                    }
                });
                
            } else {
                
                NSLog(@"\n------------------------Success Json Url------------------------\n%@\nResult:\n%@\n",request.URL,responseObject);
                
                //自定义错误
//                if ([responseObject[@"code"] integerValue] != 200) {
//
//                    NSString* errorMsg = responseObject[@"msg"];
//                    errorMsg = errorMsg.length>0?errorMsg:@"数据请求异常";
//
//                    NSString *domain = @"api.exception";
//                    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorMsg };
//                    NSError *error = [NSError errorWithDomain:domain
//                                                         code:[responseObject[@"code"] integerValue]
//                                                     userInfo:userInfo];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [JoProgressHUD makeToast:errorMsg];
//                        if (failure) {
//                            failure(error);
//                        }
//                    });
//                    return ;
//                }
                
                //接口返回数据 正常
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        success(responseObject);
                    }
                });
                
            }
        }];
        
        [task resume];
        
    });
    
}

-(void) getUrl:(nullable NSString*)URLString
         param:(nullable NSDictionary*)param
       success:(nullable AFSuccBlock)success
       failure:(nullable AFFailBlock)failure
   processView:(nullable UIView*)processView
{
    [self requestUrl:URLString param:param success:success failure:failure processView:processView method:REQUEST_METHOD_GET];
}

-(void) postUrl:(nullable NSString*)URLString
          param:(nullable NSDictionary*)param
        success:(nullable AFSuccBlock)success
        failure:(nullable AFFailBlock)failure
    processView:(nullable UIView*)processView
{
    [self requestUrl:URLString param:param success:success failure:failure processView:processView method:REQUEST_METHOD_POST];
}



@end
