//
//  NSDictionary+ZJSONString.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZJSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)z_JSONString;
@end

@interface NSArray (ZJSONArrayString)
/**
 *  @brief NSArray转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)z_JSONString;
@end
