//
//  NSString+ZContains.h
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import <Foundation/Foundation.h>

@interface NSString (ZContains)
/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)z_isContainChinese;
/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)z_isContainBlank;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)z_makeUnicodeToString;

- (BOOL)z_containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)z_containsaString:(NSString *)string;
/**
 *  @brief 获取字符数量
 */
- (int)z_wordsCount;
@end
