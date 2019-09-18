//
//  UIViewController+ZBackButtonTouched.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

typedef void (^ZBackButtonHandler)(UIViewController *vc);
@interface UIViewController (ZBackButtonTouched)
/**
 *  @author JKCategories
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler 按钮回调block
 */
-(void)z_backButtonTouched:(ZBackButtonHandler)backButtonHandler;
@end
