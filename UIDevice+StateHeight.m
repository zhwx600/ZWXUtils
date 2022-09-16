//
//  UIDevice+StateHeight.m
//  ZWXUtils
//
//  Created by zwx on 2022/9/16.
//

#import "UIDevice+StateHeight.h"

@implementation UIDevice (StateHeight)

 
// 顶部安全区高度
+ (CGFloat)z_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}
 
// 底部安全区高度
+ (CGFloat)z_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}
 
 
//顶部状态栏高度（包括安全区）
+ (CGFloat)z_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}
 
// 导航栏高度
+ (CGFloat)z_navigationBarHeight {
    return 44.0f;
}
 
// 状态栏+导航栏的高度
+ (CGFloat)z_navigationFullHeight {
    return [UIDevice z_statusBarHeight] + [UIDevice z_navigationBarHeight];
}
 
// 底部导航栏高度
+ (CGFloat)z_tabBarHeight {
    return 49.0f;
}
 
// 底部导航栏高度（包括安全区）
+ (CGFloat)z_tabBarFullHeight {
    return [UIDevice z_tabBarHeight] + [UIDevice z_safeDistanceBottom];
}
 
@end
