//
//  NSFileManager+ZPath.h
//  Pods
//
//  Created by zwx on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ZPath)

//判断文件、目录是否存在
+(BOOL) z_isExists:(NSString*)path;

//主资源目录
+ (NSString *)z_bundlePath;

//根目录
+ (NSURL *)z_homeURL;
+ (NSString *)z_homePath;

//document
+ (NSURL *)z_documentsURL;
+ (NSString *)z_documentsPath;

//library
+ (NSURL *)z_libraryURL;
+ (NSString *)z_libraryPath;

//cache
+ (NSURL *)z_cachesURL;
+ (NSString *)z_cachesPath;

//temp 文件夹
+ (NSString *)z_tempPath;

//添加一个特殊的文件系统标志到一个文件，以避免iCloud备份它。
+ (BOOL)z_addSkipBackupAttributeToFile:(NSString *)path;
//返回可用的 磁盘空间
+ (double)z_availableDiskSpace;

#pragma mark-
/**
 * 获取所有文件
 */
+(NSArray*) z_getAllFilesWithFolder:(NSString*)folder;
/**
 * 大文件 拷贝 ，循环读取数据
 */
+ (BOOL) z_copyFileFromPath:(NSString *)fromPath toPath:(NSString *)toPath;
/**
 * NSFileManager 拷贝
 */
+ (BOOL) z_copyFile2FromPath:(NSString *)fromPath toPath:(NSString *)toPath;
/**
 * 获取文件大小(字节)
 */
+(long long) z_getFileSizeWithPath:(NSString *)Path;
/**
 * 删除文件、文件夹
 */
+(BOOL) z_removeFileWithPath:(NSString *)path;
/**
 * 删除 文件夹 下所有文件、文件夹
 */
+(BOOL) z_removeAllFileWithDirectory:(NSString*) directory;
@end
