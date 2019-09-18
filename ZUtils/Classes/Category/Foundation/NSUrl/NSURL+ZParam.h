//
//  NSURL+ZParam.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface NSURL (ZParam)
/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)z_parameters;
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)z_valueForParameter:(NSString *)parameterKey;
@end
