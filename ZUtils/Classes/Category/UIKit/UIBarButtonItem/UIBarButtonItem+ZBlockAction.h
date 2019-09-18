//
//  UIBarButtonItem+ZBlockAction.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZBlockAction)

@property (nonatomic, copy) dispatch_block_t z_actionBlock;

@end
