//
//  UIView+ZAnimation.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIView (ZAnimation)
// Moves
- (void)z_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)z_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)z_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)z_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)z_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)z_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)z_spinClockwise:(float)secs;
- (void)z_spinCounterClockwise:(float)secs;

// Transitions
- (void)z_curlDown:(float)secs;
- (void)z_curlUpAndAway:(float)secs;
- (void)z_drainAway:(float)secs;

// Effects
- (void)z_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)z_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)z_addSubviewWithFadeAnimation:(UIView *)subview;
@end
