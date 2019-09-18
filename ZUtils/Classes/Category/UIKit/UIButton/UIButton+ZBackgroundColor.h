//
//  UIButton+ZBackgroundColor.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZBackgroundColor)
/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)z_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
