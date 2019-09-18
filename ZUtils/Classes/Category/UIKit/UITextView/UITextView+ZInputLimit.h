//
//  UITextView+ZInputLimit.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZInputLimit)
@property (assign, nonatomic)  NSInteger z_maxLength;//if <=0, no limit
@end
