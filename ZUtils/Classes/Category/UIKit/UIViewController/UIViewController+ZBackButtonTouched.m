//
//  UIViewController+ZBackButtonTouched.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIViewController+ZBackButtonTouched.h"
#import <objc/runtime.h>
static const void *ZBackButtonHandlerKey = &ZBackButtonHandlerKey;

@implementation UIViewController (ZBackButtonTouched)
-(void)z_backButtonTouched:(ZBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, ZBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (ZBackButtonHandler)z_backButtonTouched
{
    return objc_getAssociatedObject(self, ZBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    UIViewController* vc = [self topViewController];
    ZBackButtonHandler handler = [vc z_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    
    return NO;
}
@end
