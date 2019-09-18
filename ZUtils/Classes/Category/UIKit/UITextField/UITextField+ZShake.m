//
//  UITextField+ZShake.m
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import "UITextField+ZShake.h"

@implementation UITextField (ZShake)

- (void)z_shake {
    [self z_shake:10 withDelta:5 completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta {
    [self z_shake:times withDelta:delta completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:ZShakedDirectionHorizontal completion:handler];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self z_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:ZShakedDirectionHorizontal completion:handler];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakedDirection)shakeDirection {
    [self z_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)z_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [self _z_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_z_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ZShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == ZShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
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
             completion:handler];
    }];
}

@end
