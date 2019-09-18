//
//  UIButton+ZIndicator.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

/**
 Simple category that lets you replace the text of a button with an activity indicator.
 */

@interface UIButton (ZIndicator)

/**
 This method will show the activity indicator in place of the button text.
 */
- (void)z_showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)z_hideIndicator;
@end
