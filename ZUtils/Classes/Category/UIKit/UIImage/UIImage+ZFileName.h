//
//  UIImage+ZFileName.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZFileName)

//app icon
+(UIImage*) z_appIcon;
+(NSString*) z_appIconPath;

//app 启动图
+ (UIImage*)z_appLaunch;

//app 启动图
+ (NSString*)z_appLaunchName;

/**
 *  @brief  根据main bundle中的文件名读取图片
 *
 *  @param name 图片名
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)z_imageWithFileName:(NSString *)name;
/**
 *  @author JKCategories
 *
 *  根据指定bundle中的文件名读取图片
 *
 *  @param name   图片名
 *  @param bundle bundle
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)z_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle;

@end
