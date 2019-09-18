//
//  UITextView+ZPlaceHolder.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>
@interface UITextView (ZPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *z_placeHolderTextView;
- (void)z_addPlaceHolder:(NSString *)placeHolder;
@end
