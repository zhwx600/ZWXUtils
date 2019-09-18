//
//  UIColor+ZModify.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZModify)
//反转 颜色
- (UIColor *)z_invertedColor;
//半透明
- (UIColor *)z_colorForTranslucency;
//减轻颜色
- (UIColor *)z_lightenColor:(CGFloat)lighten;
//变暗颜色
- (UIColor *)z_darkenColor:(CGFloat)darken;
@end
