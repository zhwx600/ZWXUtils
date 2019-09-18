//
//  UIImage+ZBlur.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (ZBlur)

- (UIImage *)z_lightImage;
- (UIImage *)z_extraLightImage;
- (UIImage *)z_darkImage;
- (UIImage *)z_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)z_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)z_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)z_blurredImageWithSize:(CGSize)blurSize
                           tintColor:(UIColor *)tintColor
               saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                           maskImage:(UIImage *)maskImage;
@end
