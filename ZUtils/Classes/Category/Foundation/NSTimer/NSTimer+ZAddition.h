//
//  NSTimer+ZAddition.h
//  Pods-ZUtils_Example
//
//  Created by zwx on 2017/11/24.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ZAddition)

- (void)z_pauseTimer;
- (void)z_resumeTimer;
- (void)z_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
