//
//  UIView+ZBlockGesture.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIView+ZBlockGesture.h"

#import <objc/runtime.h>
static char z_kActionHandlerTapBlockKey;
static char z_kActionHandlerTapGestureKey;
static char z_kActionHandlerLongPressBlockKey;
static char z_kActionHandlerLongPressGestureKey;

@implementation UIView (ZBlockGesture)
- (void)z_addTapActionWithBlock:(ZGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &z_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(z_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &z_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &z_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)z_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        ZGestureActionBlock block = objc_getAssociatedObject(self, &z_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)z_addLongPressActionWithBlock:(ZGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &z_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(z_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &z_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &z_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)z_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        ZGestureActionBlock block = objc_getAssociatedObject(self, &z_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end
