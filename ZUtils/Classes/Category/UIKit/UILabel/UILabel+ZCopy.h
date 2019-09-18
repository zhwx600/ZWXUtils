//
//  UILabel+ZCopy.h
//  ZUtils
//
//  Created by zwx on 2017/11/24.
//

#import <UIKit/UIKit.h>

/**
 A category to enable long press copy feature on UILabel.
 */
@interface UILabel (ZCopy)
/**
 Set this property to YES in order to enable the copy feature. Defaults to NO.
 */
@property (nonatomic) IBInspectable BOOL z_copyingEnabled;

/**
 Used to enable/disable the internal long press gesture recognizer. Defaults to YES.
 */
@property (nonatomic) IBInspectable BOOL z_shouldUseLongPressGestureRecognizer;
@end
