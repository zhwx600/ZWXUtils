//
//  UIResponder+ZFirstResponder.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UIResponder+ZFirstResponder.h"

static __weak id z_firstResponder;

@implementation UIResponder (ZFirstResponder)
/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)z_firstResponder {
    z_firstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(z_findfirstResponder:) to:nil from:nil forEvent:nil];
    
    return z_firstResponder;
}

- (void)z_findfirstResponder:(id)sender {
    z_firstResponder = self;
}


@end
