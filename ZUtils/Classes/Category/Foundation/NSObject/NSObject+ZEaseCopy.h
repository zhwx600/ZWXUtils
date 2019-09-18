//
//  NSObject+ZEaseCopy.h
//  Pods
//
//  Created by zwx on 2017/11/20.
//

#import <Foundation/Foundation.h>


@interface NSObject (ZEaseCopy)
/**
 *  浅复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)z_easyShallowCopy:(NSObject *)instance;

/**
 *  深复制目标的所有属性
 *
 *  @param instance 目标对象
 *
 *  @return BOOL—YES:复制成功,NO:复制失败
 */
- (BOOL)z_easyDeepCopy:(NSObject *)instance;
@end
