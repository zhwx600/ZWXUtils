//
//  NSData+ZHash.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>


/**
 常用加密、解密
 */
@interface NSData (ZHash)

//不带key 的加密
@property (readonly) NSData *z_md5Data;
@property (readonly) NSData *z_sha1Data;
@property (readonly) NSData *z_sha256Data;
@property (readonly) NSData *z_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)z_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)z_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)z_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)z_hmacSHA512DataWithKey:(NSData *)key;
@end
