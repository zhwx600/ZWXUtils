//
//  UIApplication+ZNetworkActivityIndicator.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>



@interface UIApplication (ZNetworkActivityIndicator)
/**
 开启、关闭 状态栏 菊花
 */
+ (void)z_beganNetworkActivity;
+ (void)z_endedNetworkActivity;

@end

@interface UIApplication (ZKeyboardFrame)


/**
 键盘高度
 */
+ (CGRect)z_keyboardFrame;

@end
