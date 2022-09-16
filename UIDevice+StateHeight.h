//
//  UIDevice+StateHeight.h
//  ZWXUtils
//
//  Created by zwx on 2022/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (StateHeight)


/** 顶部安全区高度 **/
+ (CGFloat)z_safeDistanceTop;
 
/** 底部安全区高度 **/
+ (CGFloat)z_safeDistanceBottom;
 
/** 顶部状态栏高度（包括安全区） **/
+ (CGFloat)z_statusBarHeight;
 
/** 导航栏高度 **/
+ (CGFloat)z_navigationBarHeight;
 
/** 状态栏+导航栏的高度 **/
+ (CGFloat)z_navigationFullHeight;
 
/** 底部导航栏高度 **/
+ (CGFloat)z_tabBarHeight;
 
/** 底部导航栏高度（包括安全区） **/

@end

NS_ASSUME_NONNULL_END
