//
//  UIView+ZVisuals.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (ZVisuals)
/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)z_cornerRadius: (CGFloat)radius
            strokeSize: (CGFloat)size
                 color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)z_setRoundedCorners:(UIRectCorner)corners
                     radius:(CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)z_shadowWithColor: (UIColor *)color
                   offset: (CGSize)offset
                  opacity: (CGFloat)opacity
                   radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)z_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)z_addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)z_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)z_rotateByAngle: (CGFloat)angle
               duration: (NSTimeInterval)duration
            autoreverse: (BOOL)autoreverse
            repeatCount: (CGFloat)repeatCount
         timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)z_moveToPoint: (CGPoint)newPoint
             duration: (NSTimeInterval)duration
          autoreverse: (BOOL)autoreverse
          repeatCount: (CGFloat)repeatCount
       timingFunction: (CAMediaTimingFunction *)timingFunction;
@end
