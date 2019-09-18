//
//  NSString+ZDictionary.h
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import <Foundation/Foundation.h>

@interface NSString (ZDictionary)
/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)z_dictionaryValue;
@end
