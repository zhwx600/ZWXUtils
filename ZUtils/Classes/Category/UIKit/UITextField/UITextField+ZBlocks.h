//
//  UITextField+ZBlocks.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZBlocks)
@property (copy, nonatomic) BOOL (^z_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^z_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^z_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^z_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^z_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^z_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^z_shouldClearBlock)(UITextField *textField);

- (void)setZ_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setZ_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setZ_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setZ_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setZ_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setZ_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setZ_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
