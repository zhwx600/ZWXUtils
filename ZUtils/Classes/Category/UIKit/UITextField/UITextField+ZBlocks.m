//
//  UITextField+ZBlocks.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UITextField+ZBlocks.h"

#import <objc/runtime.h>
typedef BOOL (^ZUITextFieldReturnBlock) (UITextField *textField);
typedef void (^ZUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^ZUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (ZBlocks)
static const void *ZUITextFieldDelegateKey = &ZUITextFieldDelegateKey;
static const void *ZUITextFieldShouldBeginEditingKey = &ZUITextFieldShouldBeginEditingKey;
static const void *ZUITextFieldShouldEndEditingKey = &ZUITextFieldShouldEndEditingKey;
static const void *ZUITextFieldDidBeginEditingKey = &ZUITextFieldDidBeginEditingKey;
static const void *ZUITextFieldDidEndEditingKey = &ZUITextFieldDidEndEditingKey;
static const void *ZUITextFieldShouldChangeCharactersInRangeKey = &ZUITextFieldShouldChangeCharactersInRangeKey;
static const void *ZUITextFieldShouldClearKey = &ZUITextFieldShouldClearKey;
static const void *ZUITextFieldShouldReturnKey = &ZUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    ZUITextFieldReturnBlock block = textField.z_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    ZUITextFieldReturnBlock block = textField.z_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
    ZUITextFieldVoidBlock block = textField.z_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    ZUITextFieldVoidBlock block = textField.z_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    ZUITextFieldCharacterChangeBlock block = textField.z_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    ZUITextFieldReturnBlock block = textField.z_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ZUITextFieldReturnBlock block = textField.z_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, ZUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))z_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldShouldBeginEditingKey);
}
- (void)setZ_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))z_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldShouldEndEditingKey);
}
- (void)setZ_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))z_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldDidBeginEditingKey);
}
- (void)setZ_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))z_didEndEditingBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldDidEndEditingKey);
}
- (void)setZ_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))z_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setZ_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))z_shouldReturnBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldShouldReturnKey);
}
- (void)setZ_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))z_shouldClearBlock
{
    return objc_getAssociatedObject(self, ZUITextFieldShouldClearKey);
}
- (void)setZ_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, ZUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)z_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, ZUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
