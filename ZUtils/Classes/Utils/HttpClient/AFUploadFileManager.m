//
//  AFUploadFileManager.m
//
//  Created by zhwx on 14-10-22.
//  Copyright (c) 2014年 zhwx. All rights reserved.
//

#import "AFUploadFileManager.h"

@interface AFUploadFileManager ()

@property (nonatomic,strong) NSURLSessionUploadTask* o_uploadTask;
@property (nonatomic,strong) AFJSONRequestSerializer* o_afJSONRequestSerializer;



//------------------------------------回调Block------------------------------------------------
@property (nonatomic,copy) UploadFileSuccess o_successBlock;
@property (nonatomic,copy) UploadFileFailure o_failureBlock;
@property (nonatomic,copy) UploadFileProgress o_progressBlock;




//------------------------------------填充上传参数------------------------------------------------

/**
 * 上传的URL 地址 (必须设置，非nil)
 */
@property (nonatomic,copy) NSString* o_fullUrlString;

/**
 * 上传的文件类型 (必须设置，非nil)
 */
@property (nonatomic,assign) UploadFileType o_uploadFileType;

/**
 * 以 文件路径方式上传 或 nsdata 上传
 */
@property (nonatomic,assign) UploadMethods o_uploadMethods;
/**
 * 待上传的 NSData
 */
@property (nonatomic,strong) NSData* o_willUploadData;
/**
 * 待上传的 文件路径Path
 */
@property (nonatomic,copy) NSString* o_willUploadFilePath;


/**
 * 请求接口的额外 参数  (可为nil)
 */
@property (nonatomic,strong) NSDictionary* o_requestParams;

/**
 * data 字段的 key值， name (必须设置，非nil)
 */
@property (nonatomic,copy) NSString* o_name;

/**
 * 上传需要 要设置的 文件名称 (必须设置，非nil)
 */
@property (nonatomic,copy) NSString* o_fileName;

@end


@implementation AFUploadFileManager


-(id) init
{
    if (self = [super init]) {
        self.o_afJSONRequestSerializer = [[AFJSONRequestSerializer alloc] init];
    }
    return self;
}


+(instancetype) sharedInstance
{
    static AFUploadFileManager* __uploadFileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __uploadFileManager = [[AFUploadFileManager alloc] init];
    });
    return __uploadFileManager;
}



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
                               format:(UploadFileType)format
{
    self.o_fullUrlString = fullUrl;
    self.o_requestParams = parameters;
    self.o_willUploadData = data;
    self.o_name = keyName;
    self.o_fileName = fileName;
    self.o_uploadFileType = format;
    
    self.o_uploadMethods = UploadMethods_FileData;
}

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
                               format:(UploadFileType)format
{
    self.o_fullUrlString = fullUrl;
    self.o_requestParams = parameters;
    self.o_willUploadFilePath = filePath;
    self.o_name = keyName;
    self.o_fileName = fileName;
    self.o_uploadFileType = format;
    
    self.o_uploadMethods = UploadMethods_FilePath;
}



-(BOOL) checkAllParams
{
    if (!self.o_name || self.o_name.length<=0 || !self.o_fileName || self.o_fileName.length<=0) {
        
        NSLog(@"o_name or o_fileName is null");
        return NO;
    }
    
    if (!self.o_fullUrlString || self.o_fullUrlString.length<=0) {
        
        NSLog(@"fullUrlString is null");
        return NO;
    }

    
    if (self.o_uploadFileType != UploadFileType_JPEG
        && self.o_uploadFileType != UploadFileType_PNG
        && self.o_uploadFileType != UploadFileType_MP3) {
        
        NSLog(@"uploadFileType error");
        return NO;
    }
    
    if (self.o_uploadMethods != UploadMethods_FileData
        && self.o_uploadMethods != UploadMethods_FilePath) {
        NSLog(@"uploadMethods error");
        return NO;
    }
    
    if (!self.o_willUploadData && !self.o_willUploadFilePath) {
        NSLog(@"UploadData  UploadFilePath all is nil");
        return NO;
    }
    
    return YES;
}

/**
 * 开启上传 操作
 */
-(void) startUpload
{
    BOOL isValid = [self checkAllParams];
    
    //验证失败
    if (!isValid) {
        return;
    }

    __weak AFUploadFileManager* __myself = self;

    
    NSMutableURLRequest *request = [self.o_afJSONRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:self.o_fullUrlString parameters:self.o_requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        NSString* typeString = nil;
        if (__myself.o_uploadFileType == UploadFileType_JPEG) {
            typeString = @"image/jpeg";
        }else if (__myself.o_uploadFileType == UploadFileType_MP3){
            typeString = @"audio/mpeg3";
        }else if (__myself.o_uploadFileType == UploadFileType_PNG){
            typeString = @"image/png";
        }
        
        if (__myself.o_uploadMethods == UploadMethods_FileData) {

            [formData appendPartWithFileData:__myself.o_willUploadData name:__myself.o_name fileName:__myself.o_fileName mimeType:typeString];
            
        }else if (__myself.o_uploadMethods == UploadMethods_FilePath){

            [formData appendPartWithFileURL:[NSURL fileURLWithPath:__myself.o_willUploadFilePath] name:__myself.o_name fileName:__myself.o_fileName mimeType:typeString error:nil];
        }
        
        
    } error:nil];
    
    
    
    AFURLSessionManager* session = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 
    session.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    _o_uploadTask = [session uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        if (__myself.o_progressBlock) {
            __myself.o_progressBlock(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    }
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            if (__myself.o_failureBlock) {
                __myself.o_failureBlock(response,error);
            }
            NSLog(@"Error: %@", error);
            
        } else {
            
            if (__myself.o_successBlock) {
                __myself.o_successBlock(response,responseObject);
            }
        }
        
    }];
    
    
    [_o_uploadTask resume];
    
//    
//    //AFN3.0+基于封住HTPPSession的句柄
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSDictionary *dict = @{@"username":@"Saup"};
//    
//    
//    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
//    [manager POST:@"http://192.168.1.111:12345/upload.php" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        UIImage *image =[UIImage imageNamed:@"moon"];
//        NSData *data = UIImagePNGRepresentation(image);
//        
//        
//        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//        // 要解决此问题，
//        // 可以在上传时使用当前的系统事件作为文件名
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//        
//        //上传
//        /*
//         此方法参数
//         1. 要上传的[二进制数据]
//         2. 对应网站上[upload.php中]处理文件的[字段"file"]
//         3. 要保存在服务器上的[文件名]
//         4. 上传文件的[mimeType]
//         */
//        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        //上传进度
//        // @property int64_t totalUnitCount;     需要下载文件的总大小
//        // @property int64_t completedUnitCount; 当前已经下载的大小
//        //
//        // 给Progress添加监听 KVO
//        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//        // 回到主队列刷新UI,用户自定义的进度条
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.progressView.progress = 1.0 *
//            uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
//        });
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"上传成功 %@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"上传失败 %@", error);
//    }];
//    
//    
//    self.o_afRequestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    
////    //设置进度条 block
////    __block AFUploadFileManager* __myself = self;
//    [self.o_afRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        
//        if (__myself.o_progressBlock) {
//            __myself.o_progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
//        }
//
//    }];
//    
//    //设置失败成功 block
//    [self.o_afRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (__myself.o_successBlock) {
//            __myself.o_successBlock(operation,responseObject);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (__myself.o_failureBlock) {
//            __myself.o_failureBlock(operation,error);
//        }
//    }];
//    
//    [self.o_afRequestOperation start];

    
}

/**
 * 终止上传
 */
-(void) stopUpload
{
    [_o_uploadTask cancel];
}


//- (void)uploadImage{
//    /*
//     此段代码如果需要修改，可以调整的位置
//     1. 把upload.php改成网站开发人员告知的地址
//     2. 把file改成网站开发人员告知的字段名
//     */
//    
//    //AFN3.0+基于封住HTPPSession的句柄
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    NSDictionary *dict = @{@"username":@"Saup"};
//
//    
//    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
//    [manager POST:@"http://192.168.1.111:12345/upload.php" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        UIImage *image =[UIImage imageNamed:@"moon"];
//        NSData *data = UIImagePNGRepresentation(image);
//        
//        
//        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//        // 要解决此问题，
//        // 可以在上传时使用当前的系统事件作为文件名
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//        
//        //上传
//        /*
//         此方法参数
//         1. 要上传的[二进制数据]
//         2. 对应网站上[upload.php中]处理文件的[字段"file"]
//         3. 要保存在服务器上的[文件名]
//         4. 上传文件的[mimeType]
//         */
//        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//        //上传进度
//        // @property int64_t totalUnitCount;     需要下载文件的总大小
//        // @property int64_t completedUnitCount; 当前已经下载的大小
//        //
//        // 给Progress添加监听 KVO
//        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//        // 回到主队列刷新UI,用户自定义的进度条
//        dispatch_async(dispatch_get_main_queue(), ^{
//            double progress = 1.0 *
//            uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
//        });
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"上传成功 %@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"上传失败 %@", error);
//    }];
//    
//}


/**
 * 设置 block success failure progress
 */

-(void) setBlockWithProgress:(UploadFileProgress)progress success:(UploadFileSuccess)success failure:(UploadFileFailure)failure
{
    self.o_progressBlock = progress;
    self.o_successBlock = success;
    self.o_failureBlock = failure;
}
/**
 * 设置 block success failure
 */

-(void) setBlockWithSuccess:(UploadFileSuccess)success failure:(UploadFileFailure)failure
{
    self.o_successBlock = success;
    self.o_failureBlock = failure;

}


-(void) dealloc
{
#ifdef DEBUG
    NSLog(@"Class %@ dealloc -----!-----\n\n",[self class]);
#endif
}

@end
