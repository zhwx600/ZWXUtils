//
//  UIView+ZShake.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UIView+ZShake.h"

@implementation UIView (ZShake)

- (void)z_shake {
    [self _z_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:ZShakeDirectionHorizontal completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ZShakeDirectionHorizontal completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ZShakeDirectionHorizontal completion:handler];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ZShakeDirectionHorizontal completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ZShakeDirectionHorizontal completion:handler];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakeDirection)shakeDirection {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_z_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == ZShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self _z_shake:(times - 1)
              direction:direction * -1
           currentTimes:current + 1
              withDelta:delta
                  speed:interval
         shakeDirection:shakeDirection
             completion:completionHandler];
    }];
}

@end
