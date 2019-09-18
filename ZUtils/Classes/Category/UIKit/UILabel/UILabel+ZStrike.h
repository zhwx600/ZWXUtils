//
//  UILabel+ZStrike.h
//  Pods
//
//  Created by zwx on 2017/11/24.
//

#import <UIKit/UIKit.h>


/**
 label 中间 加删除线
 */
@interface UILabel (ZStrike)

//需要先设置 文字
-(void) z_setStrikeColor:(UIColor*)color;

@end
