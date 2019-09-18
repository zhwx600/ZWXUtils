//
//  UIImage+ZFXImage.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZFXImage)
- (UIImage *)z_imageCroppedToRect:(CGRect)rect;
- (UIImage *)z_imageScaledToSize:(CGSize)size;
- (UIImage *)z_imageScaledToFitSize:(CGSize)size;
- (UIImage *)z_imageScaledToFillSize:(CGSize)size;
- (UIImage *)z_imageCroppedAndScaledToSize:(CGSize)size
                                contentMode:(UIViewContentMode)contentMode
                                   padToFit:(BOOL)padToFit;

- (UIImage *)z_reflectedImageWithScale:(CGFloat)scale;
- (UIImage *)z_imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;
- (UIImage *)z_imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
- (UIImage *)z_imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)z_imageWithAlpha:(CGFloat)alpha;
- (UIImage *)z_imageWithMask:(UIImage *)maskImage;

- (UIImage *)z_maskImageFromImageAlpha;
@end
