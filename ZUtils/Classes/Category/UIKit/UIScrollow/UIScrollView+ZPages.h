//
//  UIScrollView+ZPages.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZPages)
- (NSInteger)z_pages;
- (NSInteger)z_currentPage;
- (CGFloat)z_scrollPercent;

- (CGFloat)z_pagesY;
- (CGFloat)z_pagesX;
- (CGFloat)z_currentPageY;
- (CGFloat)z_currentPageX;
- (void)z_setPageY:(CGFloat)page;
- (void)z_setPageX:(CGFloat)page;
- (void)z_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)z_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
