//
//  UITextView+ZSelect.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZSelect)
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



//https://github.com/pclion/TextViewCalculateLength
// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)z_getInputLengthWithText:(NSString *)text;
/*
 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
 {
 NSInteger textLength = [textView getInputLengthWithText:text];
 if (textLength > 20) {
 //超过20个字可以删除
 if ([text isEqualToString:@""]) {
 return YES;
 }
 return NO;
 }
 return YES;
 }
 
 - (void)textViewDidChange:(UITextView *)textView
 {
 if ([textView getInputLengthWithText:nil] > 20) {
 textView.text = [textView.text substringToIndex:20];
 }
 }
 */
@end
