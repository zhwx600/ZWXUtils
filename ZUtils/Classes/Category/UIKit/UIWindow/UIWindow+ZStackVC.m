//
//  UIWindow+ZStackVC.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIWindow+ZStackVC.h"

@implementation UIWindow (ZStackVC)

/**
 *    获取当前Application的keyWindow
 */
+ (UIWindow *)z_keyWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window;
}


+(UIViewController*)z_topMostController
{
    UIWindow* window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topController = [window rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])
        topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

+(UIViewController*)z_currentViewController
{
    UIViewController *currentViewController = [self z_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}
@end
