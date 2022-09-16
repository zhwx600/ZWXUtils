//
//  NSObject+ZGCD.m
//  Pods
//
//  Created by zwx on 2017/11/20.
//

#import "NSObject+ZGCD.h"

@implementation NSObject (ZGCD)
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)z_performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param shouldWait  是否同步请求
 */
- (void)z_performOnMainThread:(void(^)(void))block wait:(BOOL)shouldWait {
    if (shouldWait) {
        // Synchronous
        dispatch_sync(dispatch_get_main_queue(), block);
    }
    else {
        // Asynchronous
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)z_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_current_queue(), block);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
    
}
@end
