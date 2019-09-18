//
//  UIView+ZFrame.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIView+ZFrame.h"

@implementation UIView (ZFrame)
#pragma mark - Shortcuts for the coords

- (CGFloat)z_top
{
    return self.frame.origin.y;
}

- (void)setZ_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)z_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setZ_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)z_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setZ_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)z_left
{
    return self.frame.origin.x;
}

- (void)setZ_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)z_width
{
    return self.frame.size.width;
}

- (void)setZ_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)z_height
{
    return self.frame.size.height;
}

- (void)setZ_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)z_origin {
    return self.frame.origin;
}

- (void)setZ_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)z_size {
    return self.frame.size;
}

- (void)setZ_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)z_centerX {
    return self.center.x;
}

- (void)setZ_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)z_centerY {
    return self.center.y;
}

- (void)setZ_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void) setZ_x:(CGFloat) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (void) setZ_y:(CGFloat) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (CGFloat) z_x {
    return self.frame.origin.x;
}

- (CGFloat) z_y {
    return self.frame.origin.y;
}


#pragma mark - Border & Radius

- (void)setZ_borderColor:(UIColor *)z_borderColor {
    self.layer.borderColor = z_borderColor.CGColor;
}

- (UIColor *)z_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setZ_borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)z_borderWidth {
    return self.layer.borderWidth;
}

- (void)setZ_cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

- (CGFloat)z_cornerRadius {
    return self.layer.cornerRadius;
}

#pragma mark-
/**
 *  设置 Autoresizing 支持所有属性
 */
- (void)z_setAutoresizingAll
{
    UIViewAutoresizing autoresize = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    
    self.autoresizingMask = autoresize;
}
/**
 *  设置 Autoresizing 支持 WH自动拉伸 属性
 */
- (void)z_setAutoresizingWH
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


@end
