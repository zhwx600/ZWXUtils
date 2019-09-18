//
//  UIView+ZFrame.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIView (ZFrame)

@property (nonatomic) CGFloat z_x;
@property (nonatomic) CGFloat z_y;
@property (nonatomic) CGFloat z_width;
@property (nonatomic) CGFloat z_height;

@property (nonatomic, assign) CGPoint z_origin;
@property (nonatomic, assign) CGSize z_size;

// shortcuts for positions
@property (nonatomic) CGFloat z_centerX;
@property (nonatomic) CGFloat z_centerY;

@property (nonatomic) CGFloat z_left;
@property (nonatomic) CGFloat z_right;
@property (nonatomic) CGFloat z_top;
@property (nonatomic) CGFloat z_bottom;


@property (nonatomic, assign) UIColor *z_borderColor;
@property (nonatomic, assign) CGFloat z_borderWidth;
@property (nonatomic, assign) CGFloat z_cornerRadius;

/**
 *  设置 Autoresizing 支持所有属性
 */
- (void)z_setAutoresizingAll;
/**
 *  设置 Autoresizing 支持 WH自动拉伸 属性
 */
- (void)z_setAutoresizingWH;

@end
