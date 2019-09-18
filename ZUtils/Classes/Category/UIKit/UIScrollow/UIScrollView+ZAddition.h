//
//  UIScrollView+ZAddition.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZScrollDirection) {
    ZScrollDirectionUp,
    ZScrollDirectionDown,
    ZScrollDirectionLeft,
    ZScrollDirectionRight,
    ZScrollDirectionWTF
};


@interface UIScrollView (ZAddition)
@property(nonatomic) CGFloat z_contentWidth;
@property(nonatomic) CGFloat z_contentHeight;
@property(nonatomic) CGFloat z_contentOffsetX;
@property(nonatomic) CGFloat z_contentOffsetY;

- (CGPoint)z_topContentOffset;
- (CGPoint)z_bottomContentOffset;
- (CGPoint)z_leftContentOffset;
- (CGPoint)z_rightContentOffset;

- (ZScrollDirection)z_ScrollDirection;

- (BOOL)z_isScrolledToTop;
- (BOOL)z_isScrolledToBottom;
- (BOOL)z_isScrolledToLeft;
- (BOOL)z_isScrolledToRight;
- (void)z_scrollToTopAnimated:(BOOL)animated;
- (void)z_scrollToBottomAnimated:(BOOL)animated;
- (void)z_scrollToLeftAnimated:(BOOL)animated;
- (void)z_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)z_verticalPageIndex;
- (NSUInteger)z_horizontalPageIndex;

- (void)z_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)z_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
