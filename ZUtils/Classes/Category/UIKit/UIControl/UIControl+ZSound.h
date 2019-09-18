//
//  UIControl+ZSound.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZSound)

//不同事件增加不同声音
//name 为 音频资源文件名称
- (void)z_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
