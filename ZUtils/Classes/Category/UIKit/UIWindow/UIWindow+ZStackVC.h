//
//  UIWindow+ZStackVC.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ZStackVC)

/**
 *    获取当前Application的keyWindow
 */
+ (UIWindow *)z_keyWindow;

//返回层级中当前最顶级的ViewController
+(UIViewController*)z_topMostController;
//返回层级中当前的ViewController
+(UIViewController*)z_currentViewController;

@end
