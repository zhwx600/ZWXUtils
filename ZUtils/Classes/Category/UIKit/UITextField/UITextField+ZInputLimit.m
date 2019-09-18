//
//  UITextField+ZInputLimit.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UITextField+ZInputLimit.h"

#import <objc/runtime.h>

static const void *ZTextFieldInputLimitMaxLength = &ZTextFieldInputLimitMaxLength;
@implementation UITextField (ZInputLimit)

- (NSInteger)z_maxLength {
    return [objc_getAssociatedObject(self, ZTextFieldInputLimitMaxLength) integerValue];
}
- (void)setZ_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, ZTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(z_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)z_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.z_maxLength > 0 && toBeString.length > self.z_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.z_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.z_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.z_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.z_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
