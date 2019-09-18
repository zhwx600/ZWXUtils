//
//  UINavigationController+ZTransitions.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

//动画方式

@interface UINavigationController (ZTransitions)
- (void)z_pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;
- (UIViewController *)z_popViewControllerWithTransition:(UIViewAnimationTransition)transition;
@end
