//
//  UIButton+ZCountDown.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>


/**
 用于 短信验证码倒计时
 */
@interface UIButton (ZCountDown)


/**
 设置UIButton 自动倒计时

 @param timeout 倒计时超时时间。如:6、120
 @param title 倒计时结束时按钮的标题。（可点击状态）如: @"重新获取验证码"
 @param format 等待过程中标题的显示字符串格式。（不可点击状态） 如:@"重新发送(%02lds)"
 */
-(void)z_startTime:(NSInteger )timeout title:(NSString *)title waitTFormat:(NSString *)format;

@end
