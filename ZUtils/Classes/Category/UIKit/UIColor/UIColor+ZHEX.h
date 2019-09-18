//
//  UIColor+ZHEX.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZHEX)
+ (UIColor *)z_colorWithHex:(UInt32)hex;
+ (UIColor *)z_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)z_colorWithHexString:(NSString *)hexString;
- (NSString *)z_HEXString;
///值不需要除以255.0
+ (UIColor *)z_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)z_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;
@end
