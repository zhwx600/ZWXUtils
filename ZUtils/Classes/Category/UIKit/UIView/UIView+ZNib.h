//
//  UIView+ZNib.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIView (ZNib)

/**
 *  自动从xib创建视图
 */
+(instancetype) z_viewFromXIB;


+ (UINib *)z_loadNib;
+ (UINib *)z_loadNibNamed:(NSString*)nibName;
+ (UINib *)z_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)z_loadInstanceFromNib;
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)z_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;
@end
