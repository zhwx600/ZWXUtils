//
//  UIDevice+ZHardware.h
//  Pods
//
//  Created by zwx on 2017/11/23.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZHardware)
+ (NSString *)z_platform;
+ (NSString *)z_platformString;


+ (NSString *)z_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)z_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)z_busFrequency;
//current device RAM size
+ (NSUInteger)z_ramSize;
//Return the current device CPU number
+ (NSUInteger)z_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)z_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)z_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)z_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)z_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)z_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)z_totalDiskSpaceBytes;
@end
