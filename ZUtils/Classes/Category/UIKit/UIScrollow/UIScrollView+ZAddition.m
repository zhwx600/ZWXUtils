//
//  UIScrollView+ZAddition.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIScrollView+ZAddition.h"

@implementation UIScrollView (ZAddition)

//frame
- (CGFloat)z_contentWidth {
    return self.contentSize.width;
}
- (void)setZ_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)z_contentHeight {
    return self.contentSize.height;
}
- (void)setZ_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)z_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setZ_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)z_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setZ_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)z_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)z_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)z_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)z_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (ZScrollDirection)z_ScrollDirection
{
    ZScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = ZScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = ZScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = ZScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = ZScrollDirectionRight;
    }
    else
    {
        direction = ZScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)z_isScrolledToTop
{
    return self.contentOffset.y <= [self z_topContentOffset].y;
}
- (BOOL)z_isScrolledToBottom
{
    return self.contentOffset.y >= [self z_bottomContentOffset].y;
}
- (BOOL)z_isScrolledToLeft
{
    return self.contentOffset.x <= [self z_leftContentOffset].x;
}
- (BOOL)z_isScrolledToRight
{
    return self.contentOffset.x >= [self z_rightContentOffset].x;
}
- (void)z_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self z_topContentOffset] animated:animated];
}
- (void)z_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self z_bottomContentOffset] animated:animated];
}
- (void)z_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self z_leftContentOffset] animated:animated];
}
- (void)z_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self z_rightContentOffset] animated:animated];
}
- (NSUInteger)z_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)z_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)z_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)z_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end

