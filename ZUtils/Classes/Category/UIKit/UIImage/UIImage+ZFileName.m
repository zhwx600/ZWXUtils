//
//  UIImage+ZFileName.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIImage+ZFileName.h"

@implementation UIImage (ZFileName)

+ (NSString*)z_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

+ (UIImage*)z_appIcon {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    UIImage*appIcon = [UIImage imageNamed:iconLastName];
    return appIcon;
}

+ (UIImage*)z_appLaunch {
    
    NSString* launchImageName = [[self class] z_appLaunchName];
    if (launchImageName.length <= 0) {
        return nil;
    }
    //设备启动图片为控制器的背景图片
    UIImage *img = [UIImage imageNamed:launchImageName];
    return img;
}

+ (NSString*)z_appLaunchName {
    NSString *launchImageName = @""; //启动图片名称变量
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height; //屏幕高度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width; //屏幕宽度
    //设备界面方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);// 是否竖屏
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);//是否横屏
    //获取与当前设备匹配的启动图片名称
    //4、4S 竖屏，横屏
    if ((isPortrait && screenHeight == 480) || (isLandscape && screenWidth == 480)){
        launchImageName = @"LaunchImage-700";
    }
    //5、5C、5S、iPod 竖屏，横屏
    else if ((isPortrait && screenHeight == 568) || (isLandscape && screenWidth == 568)){
        launchImageName = @"LaunchImage-700-568h";
    }
    //6、6S 竖屏，横屏
    else if ((isPortrait && screenHeight == 667) || (isLandscape && screenWidth == 667)){
        launchImageName = @"LaunchImage-800-667h";
    }
    //6Plus、6SPlus竖屏
    else if (isPortrait && screenHeight == 736){
        launchImageName = @"LaunchImage-800-Portrait-736h";
    }
    //6Plus、6SPlus 横屏
    else if (isLandscape && screenWidth == 736){
        launchImageName = @"LaunchImage-800-Landscape-736h";
    }
    //iPad 竖屏
    else if (isPortrait && screenHeight == 1024){
        launchImageName = @"LaunchImage-700-Portrait";
    }
    //iPad 横屏
    else if (isLandscape && screenWidth == 1024){
        launchImageName = @"LaunchImage-700-Landscape";
    }
    if (launchImageName.length < 1)
        launchImageName = @"LaunchImage-1100-Portrait-2436h";

    return launchImageName;
}


/**
 *  @brief  根据bundle中的文件名读取图片
 *
 *  @param name 图片名
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)z_imageWithFileName:(NSString *)name {
    return [self z_imageWithFileName:name inBundle:[NSBundle mainBundle]];
}
+ (UIImage *)z_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle{
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [bundle pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}
@end
