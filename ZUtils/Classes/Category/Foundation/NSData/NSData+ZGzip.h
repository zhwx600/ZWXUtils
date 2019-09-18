//
//  NSData+ZGzip.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface NSData (ZGzip)
/**
 *  @brief  GZIP压缩
 *
 *  @param level 压缩级别
 *
 *  @return 压缩后的数据
 */
- (NSData *)z_gzippedDataWithCompressionLevel:(float)level;

/**
 *  @brief  GZIP压缩 压缩级别 默认-1
 *
 *  @return 压缩后的数据
 */
- (NSData *)z_gzippedData;

/**
 *  @brief  GZIP解压
 *
 *  @return 解压后数据
 */
- (NSData *)z_gunzippedData;

- (BOOL)z_isGzippedData;
@end




@interface NSData (ZAPNSToken)
/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 整理过后的字符串token
 */
- (NSString *)z_APNSToken;
@end
