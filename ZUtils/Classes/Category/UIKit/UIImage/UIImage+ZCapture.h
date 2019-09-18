//
//  UIImage+ZCapture.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZCapture)
/**
 *  @brief  截图指定view成图片
 *
 *  @param view 一个view
 *
 *  @return 图片
 */
+ (UIImage *)z_captureWithView:(UIView *)view;

+ (UIImage *)z_getImageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param aView    指定的view
 *  @param maxWidth 宽的大小 0为view默认大小
 *
 *  @return 截图
 */
+ (UIImage *)z_screenshotWithView:(UIView *)aView limitWidth:(CGFloat)maxWidth;
@end
