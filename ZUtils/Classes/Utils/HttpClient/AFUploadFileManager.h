//
//  AFUploadFileManager.h
//
//  Created by zhwx on 14-10-22.
//  Copyright (c) 2014年 zhwx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

typedef void(^UploadFileSuccess)(NSURLResponse *response,id responseObject);
typedef void(^UploadFileFailure)(NSURLResponse *response,NSError *error);
typedef void (^UploadFileProgress)(int64_t bytes, int64_t totalBytes);

/**
 * 上传文件类型
 */
typedef NS_ENUM(NSUInteger, UploadFileType) {
    UploadFileType_JPEG,//@"image/jpeg"
    UploadFileType_PNG,//@"image/png"
    UploadFileType_MP3,//@"audio/mpeg3"
};

/**
 * 上传方式
 */
typedef NS_ENUM(NSUInteger, UploadMethods) {
    UploadMethods_FileData,
    UploadMethods_FilePath,
};


@interface AFUploadFileManager : NSObject


// 方法
+(instancetype) sharedInstance;



/**
 * -------------------------以NSData 方式上传--------------------------
 * fullUrl:上传地址url全路径
 * parameters: 额外的上传参数  【选填参数】
 * data:文件流
 *
 * keyName:data 的 键值名称
 * fileName:文件名 （http 头部用）
 * format:上传的文件类型  eg:@"image/jpeg" 等
 */
-(void) setFileDataMethodsWithFullUrl:(NSString*)fullUrl
                           parameters:(NSDictionary *)parameters
                                 data:(NSData*)data
                              keyName:(NSString*)keyName
                             fileName:(NSString*)fileName
                               format:(UploadFileType)format;

/**
 * -------------------------以FilePath 方式上传--------------------------
 * fullUrl:上传地址url全路径
 * parameters: 额外的上传参数  【选填参数】
 * filePath:本地待上传文件的 全路径
 *
 * keyName:data 的 键值名称
 * fileName:文件名 （http 头部用）
 * format:上传的文件类型  eg:@"image/jpeg" 等
 */
-(void) setFilePathMethodsWithFullUrl:(NSString*)fullUrl
                           parameters:(NSDictionary *)parameters
                             filePath:(NSString*)filePath
                              keyName:(NSString*)keyName
                             fileName:(NSString*)fileName
                               format:(UploadFileType)format;



/**
 * 设置 block success failure progress
 */

-(void) setBlockWithProgress:(UploadFileProgress)progress success:(UploadFileSuccess)success failure:(UploadFileFailure)failure;

/**
 * 设置 block success failure
 */

-(void) setBlockWithSuccess:(UploadFileSuccess)success failure:(UploadFileFailure)failure;
/**
 * 开启上传 操作
 */
-(void) startUpload;

/**
 * 终止上传
 */
-(void) stopUpload;

@end
