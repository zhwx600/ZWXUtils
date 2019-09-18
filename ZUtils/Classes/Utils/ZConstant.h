//
//  ZConstant.h
//  PaixieMall
//
//  Created by zhwx on 15/1/8.
//  Copyright (c) 2015年 拍鞋网. All rights reserved.
//

#ifndef PaixieMall_ZConstant_h
#define PaixieMall_ZConstant_h

//判断高于系统版本
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
#define IS_IOS_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10)
#define IS_IOS_11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11)

#define IS_EQUAL_IOS(v) ([[[UIDevice currentDevice] systemVersion] floatValue] == v)//等于此版本
#define IS_GREAT_IOS(v) ([[[UIDevice currentDevice] systemVersion] floatValue] >= v)//高于此版本
#define IS_LESS_IOS(v) ([[[UIDevice currentDevice] systemVersion] floatValue] <= v)//低于此版本


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //全局并发队列
#define kMainQueue dispatch_get_main_queue() //主线程队列

//格式化 字符串
#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

//编码
#define ENC_GB1832 CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000)

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBSINGLE(v) [UIColor colorWithRed:(v)/255.0f green:(v)/255.0f blue:(v)/255.0f alpha:1]

//数值转字符串
#define STRING_NO_NULL(value) [NSString stringWithFormat:@"%@",value?value:@""]
#define STRING_INT(value) [NSString stringWithFormat:@"%ld",(long)value]
#define STRING_FLOAT(value) [NSString stringWithFormat:@"%.2f",(double)value]
#define STRING_FLOAT_P(value) [NSString stringWithFormat:@"￥%.2f",(double)value]

//π 和 度数转弧度
#define M_PI   3.14159265358979323846264338327950288
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)


/********************* 屏幕宽高值 *********************/
// 屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH_2          (SCREEN_WIDTH / 2)
#define SCREEN_HEIGHT_2         (SCREEN_HEIGHT / 2)
//屏幕比例
#define SCREEN_SCALE ([UIScreen mainScreen].scale)


/********************* 手机屏幕尺寸判断 *********************/
#define IS_IPHONE4  ( fabsl( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE5  ( fabsl( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE6  ( fabsl( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE6P  ( fabsl( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
//iPhoneX / iPhoneXS
#define IS_IPHONE_X_XS  (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define IS_IPHONE_XR_XSMax (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
//异性全面屏
#define IS_FULL_SCREEN (IS_IPHONE_X_XS || IS_IPHONE_XR_XSMax)

/********************* 系统控件宽高 *********************/
#define STATUS_HEIGHT (IS_FULL_SCREEN ? 44.f : 20.f)
#define NAVBAR_HEIGHT 44.f
#define TABBAR_HEIGHT (IS_FULL_SCREEN ? (49.f+34.f) : 49.f)
#define TABBAR_SafeBottomMargin (IS_FULL_SCREEN ? 34.f : 0.f)
#define STATUS_AND_NAVBAR_HEIGHT (IS_FULL_SCREEN ? 88.f : 64.f)

//屏幕相对于 375 的比例
#define SCREEN_S_WIDTH 375.0f //(IPHONE7)
#define SCREEN_S_SCALE (SCREEN_WIDTH / SCREEN_S_WIDTH)

//获取 弱引用self（常用于block时）
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif
