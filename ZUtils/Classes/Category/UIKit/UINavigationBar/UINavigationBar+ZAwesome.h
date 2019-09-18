//
//  UINavigationBar+ZAwesome.h
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZAwesome)

@property (nonatomic,strong) UIView* z_overlay;


- (void)z_setBackgroundColor:(UIColor *)backgroundColor;
- (void)z_setElementsAlpha:(CGFloat)alpha;
- (void)z_setTranslationY:(CGFloat)translationY;
- (void)z_reset;


@end
