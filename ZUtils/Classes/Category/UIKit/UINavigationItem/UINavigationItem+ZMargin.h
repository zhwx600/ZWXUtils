//
//  UINavigationItem+ZMargin.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

// https://github.com/devxoul/UINavigationItem-Margin
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UINavigationItem_MarginVersionNumber;
FOUNDATION_EXPORT const unsigned char UINavigationItem_MarginVersionString[];

@interface UINavigationItem (ZMargin)

@property (nonatomic, assign) CGFloat z_leftMargin;
@property (nonatomic, assign) CGFloat z_rightMargin;

+ (CGFloat)z_systemMargin;

@end
