//
//  NSTimer+ZAddition.m
//  Pods-ZUtils_Example
//
//  Created by zwx on 2017/11/24.
//

#import "NSTimer+ZAddition.h"

@implementation NSTimer (ZAddition)
-(void)z_pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)z_resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)z_resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
