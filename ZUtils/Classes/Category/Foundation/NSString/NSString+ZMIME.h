//
//  NSString+ZMIME.h
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import <Foundation/Foundation.h>


/**
 获取 文件 的http传输 的消息内容类型
 */
@interface NSString (ZMIME)
/**
 *  @brief  根据文件url 返回对应的MIMEType
 *
 *  @return MIMEType
 */
- (NSString *)z_MIMEType;
/**
 *  @brief  根据文件url后缀 返回对应的MIMEType
 *
 *  @return MIMEType
 */
+ (NSString *)z_MIMETypeForExtension:(NSString *)extension;
/**
 *  @brief  常见MIME集合
 *
 *  @return 常见MIME集合
 */
+ (NSDictionary *)z_MIMEDict;
@end
