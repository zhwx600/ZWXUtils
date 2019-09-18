//
//  UINavigationBar+ZAwesome.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UINavigationBar+ZAwesome.h"
#import <objc/runtime.h>


@implementation UINavigationBar (ZAwesome)
static char z_overlayKey;

- (UIView *)z_overlay
{
    return objc_getAssociatedObject(self, &z_overlayKey);
}

- (void)setZ_overlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &z_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)z_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.z_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.z_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.z_overlay.userInteractionEnabled = NO;
        self.z_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.z_overlay atIndex:0];
    }
    self.z_overlay.backgroundColor = backgroundColor;
}

- (void)z_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)z_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)z_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.z_overlay removeFromSuperview];
    self.z_overlay = nil;
}
@end
