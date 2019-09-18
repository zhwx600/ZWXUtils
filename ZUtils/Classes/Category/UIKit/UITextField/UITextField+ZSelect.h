//
//  UITextField+ZSelect.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)z_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)z_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)z_setSelectedRange:(NSRange)range;
@end
