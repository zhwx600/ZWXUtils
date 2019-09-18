//
//  UINavigationItem+ZLock.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

//锁住 按钮 不能操作。 即设置 enable 
@interface UINavigationItem (ZLock)
/**
 *  @brief  锁定RightItem
 *
 *  @param lock 是否锁定
 */
- (void)z_lockRightItem:(BOOL)lock;
/**
 *  @brief  锁定LeftItem
 *
 *  @param lock 是否锁定
 */
- (void)z_lockLeftItem:(BOOL)lock;
@end
