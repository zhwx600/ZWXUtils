//
//  UIControl+ZBlock.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZBlock)

- (void)z_touchDown:(void (^)(id))eventBlock;
- (void)z_touchDownRepeat:(void (^)(id))eventBlock;
- (void)z_touchDragInside:(void (^)(id))eventBlock;
- (void)z_touchDragOutside:(void (^)(id))eventBlock;
- (void)z_touchDragEnter:(void (^)(id))eventBlock;
- (void)z_touchDragExit:(void (^)(id))eventBlock;
- (void)z_touchUpInside:(void (^)(id))eventBlock;
- (void)z_touchUpOutside:(void (^)(id))eventBlock;
- (void)z_touchCancel:(void (^)(id))eventBlock;
- (void)z_valueChanged:(void (^)(id))eventBlock;
- (void)z_editingDidBegin:(void (^)(id))eventBlock;
- (void)z_editingChanged:(void (^)(id))eventBlock;
- (void)z_editingDidEnd:(void (^)(id))eventBlock;
- (void)z_editingDidEndOnExit:(void (^)(id))eventBlock;

@end
