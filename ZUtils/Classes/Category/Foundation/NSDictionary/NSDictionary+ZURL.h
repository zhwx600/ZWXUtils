//
//  NSDictionary+ZURL.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZURL)
/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)z_dictionaryWithURLQuery:(NSString *)query;
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)z_URLQueryString;
@end
