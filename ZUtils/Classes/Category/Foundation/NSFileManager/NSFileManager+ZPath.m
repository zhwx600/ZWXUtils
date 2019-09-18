//
//  NSFileManager+ZPath.m
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import "NSFileManager+ZPath.h"
#include <sys/xattr.h>

@implementation NSFileManager (ZPath)

//判断文件、目录是否存在
+(BOOL) z_isExists:(NSString*)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return YES;
    }
    return NO;
}

//主资源目录
+ (NSString *)z_bundlePath
{
    return [[NSBundle mainBundle] bundlePath];
}

//根目录
+ (NSURL *)z_homeURL
{
    return [NSURL fileURLWithPath:NSHomeDirectory()];
}
+ (NSString *)z_homePath
{
    return NSHomeDirectory();
}

//temp 文件夹
+ (NSString *)z_tempPath
{
    return NSTemporaryDirectory();
}

+ (NSURL *)z_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)z_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)z_documentsURL
{
    return [self z_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)z_documentsPath
{
    return [self z_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)z_libraryURL
{
    return [self z_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)z_libraryPath
{
    return [self z_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)z_cachesURL
{
    return [self z_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)z_cachesPath
{
    return [self z_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)z_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)z_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.z_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

#pragma mark-
/**
 * 获取所有文件
 */
+(NSArray*) z_getAllFilesWithFolder:(NSString*)folder
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    return [fileManager contentsOfDirectoryAtPath:folder error:&error];
}


+ (BOOL) z_copyFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    //每次读取数据大小
#define READ_SIZE 1000
    // 获取文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 创建目标文件,用于存储从源文件读取的NSData数据
    
    BOOL isSuccess = [fm createFileAtPath:toPath contents:nil attributes:nil];
    
    if (!isSuccess) {
        NSLog(@"创建目标文件失败!");
        return NO;
    }
    // 获取源文件大小
    NSDictionary *dic = [fm attributesOfItemAtPath:fromPath error:nil];
    NSNumber *file_size = [dic objectForKey:@"NSFileSize"];
    NSNumber *hadReadSize = @0;
    double leftSize = [file_size doubleValue] - [hadReadSize doubleValue];
    // 创建源文件和目标文件的句柄
    NSFileHandle *sh = [NSFileHandle fileHandleForReadingAtPath:fromPath];
    NSFileHandle *dh = [NSFileHandle fileHandleForWritingAtPath:toPath];
    NSData *tempData = nil;
    while (leftSize > 0) {
        if (leftSize < READ_SIZE) {
            tempData = [sh readDataToEndOfFile];
            [dh writeData:tempData];
            break;
        }
        else
        {
            tempData = [sh readDataOfLength:READ_SIZE];
            [dh writeData:tempData];
            leftSize -= READ_SIZE;
        }
        
    }
    
    return YES;
}

/**
 * NSFileManager 拷贝
 */
+ (BOOL) z_copyFile2FromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    NSFileManager *fm  = [NSFileManager defaultManager];
    
    return [fm copyItemAtPath:fromPath toPath:toPath error:nil];
}

/**
 * 获取文件大小
 */
+(long long) z_getFileSizeWithPath:(NSString *)Path
{
    NSFileManager *fm  = [NSFileManager defaultManager];
    
    // 取文件大小
    NSError *error = nil;
    NSDictionary* dictFile = [fm attributesOfItemAtPath:Path error:&error];
    if (error)
    {
        NSLog(@"getfilesize error: %@", error);
        return -1;
    }
    long long nFileSize = [dictFile fileSize]; //得到文件大小
    
    return nFileSize;
}

/**
 * 删除文件、文件夹
 */
+(BOOL) z_removeFileWithPath:(NSString *)path
{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/**
 * 删除 文件夹 下所有文件、文件夹
 */
+(BOOL) z_removeAllFileWithDirectory:(NSString*) directory
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath:directory isDirectory:&isDirectory]) {
        return NO;
    }
    
    NSArray* files = [fileManager contentsOfDirectoryAtPath:directory error:nil];
    
    NSLog(@"Removing dir: %@", directory);
    
    for (NSString *file in files) {
        NSString *filePath = [directory stringByAppendingPathComponent:file];
        NSLog(@"Removing file : %@", filePath);
        
        if ([fileManager removeItemAtPath:filePath error:&error] != YES) {
            NSInteger errCode = (error!=nil ? error.code : -1);
            NSLog(@"Removing file error: [error code:%ld], [file:%@]", (long)errCode, filePath);
        }
    }
    
    return YES;
}



@end
