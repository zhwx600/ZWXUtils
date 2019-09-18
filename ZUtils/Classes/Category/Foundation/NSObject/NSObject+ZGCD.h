//
//  NSObject+ZGCD.h
//  Pods
//
//  Created by zwx on 2017/11/20.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZGCD)
/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)z_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)z_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)z_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;
@end
