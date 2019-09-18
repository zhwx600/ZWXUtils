//
//  UIViewController+ZBackButtonItemTitle.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@protocol ZBackButtonItemTitleProtocol <NSObject>

@optional
- (NSString *)z_navigationItemBackBarButtonTitle; //The length of the text is limited, otherwise it will be set to "Back"

@end

@interface UIViewController (ZBackButtonItemTitle) <ZBackButtonItemTitleProtocol>

@end
