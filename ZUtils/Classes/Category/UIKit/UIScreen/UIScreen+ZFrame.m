//
//  UIScreen+ZFrame.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIScreen+ZFrame.h"

@implementation UIScreen (ZFrame)

+(CGRect) z_frame
{
    return [[UIScreen mainScreen] bounds];
}


+ (CGSize)z_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)z_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)z_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)z_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? z_SizeSWAP([UIScreen z_size]) : [UIScreen z_size];
}

+ (CGFloat)z_orientationWidth
{
    return [UIScreen z_orientationSize].width;
}

+ (CGFloat)z_orientationHeight
{
    return [UIScreen z_orientationSize].height;
}

+ (CGSize)z_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}


/**
 *  交换高度与宽度
 */
static inline CGSize z_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}
@end
