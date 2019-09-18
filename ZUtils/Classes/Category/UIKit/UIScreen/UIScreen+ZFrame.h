//
//  UIScreen+ZFrame.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ZFrame)

+ (CGRect)z_frame;
+ (CGSize)z_size;
+ (CGFloat)z_width;
+ (CGFloat)z_height;

+ (CGSize)z_orientationSize;
+ (CGFloat)z_orientationWidth;
+ (CGFloat)z_orientationHeight;
+ (CGSize)z_DPISize;//物理像素大小
@end
