//
//  UIApplication+ZNetworkActivityIndicator.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIApplication+ZNetworkActivityIndicator.h"
#import <libkern/OSAtomic.h>

@implementation UIApplication (ZNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsxxx;

#pragma mark Public API

+ (void)z_beganNetworkActivity
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

+ (void)z_endedNetworkActivity
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsxxx) > 0;
}

@end

@implementation UIApplication (ZKeyboardFrame)
static CGRect _z_keyboardFrame = (CGRect){ (CGPoint){ 0.0f, 0.0f }, (CGSize){ 0.0f, 0.0f } };

+ (CGRect)z_keyboardFrame {
    return _z_keyboardFrame;
}

+ (void)load
{
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _z_keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _z_keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidHideNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _z_keyboardFrame = CGRectZero;
     }];
}
@end

