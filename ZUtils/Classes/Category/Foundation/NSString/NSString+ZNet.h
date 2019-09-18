//
//  NSString+ZNet.h
//  Pods
//
//  Created by zwx on 2017/11/24.
//

#import <Foundation/Foundation.h>

@interface NSString (ZNet)
/**
 * 获取本机的 外网IP  http://ip.3322.org/
 */
+(NSString*) z_getPublicNetworkIp;

/**
 * 获取本机的 外网IP  http://www.ip.cn/
 */
+(NSString*) z_getPublicNetworkIp2;

/**
 * 获取本机的 外网IP http://www.ip38.com/
 */
+(NSString*) z_getPublicNetworkIp3;


/**
 * 获取本机的内网IP
 */
+ (NSString *)z_getIPAddressWithIsIp4:(BOOL)isIPv4;

/**
 * 获取本机的内网IP
 */
+ (NSDictionary *)z_getIPAddresses;


/**
 * 获取一个自动增长的 unsigned short
 */
+(unsigned short) z_getAddShortValue;

/**
 * 测试是否是 大端 在前
 */
+(BOOL) z_isBitEndianTest;

/**
 * 交换 short 高低字节序
 */
+(short) z_swap16WithShort:(short)value;

/**
 * 交换 int 高低字节序
 */
+(int) z_swap32WithInt:(int)value;

/**
 * 交换 long long 高低字节序
 */
+(long long) z_swap64WithLongLong:(long long)value;


/**
 * 是否显示 加载网络(系统)
 */
+(void) z_showNetWorkIcon:(bool)bShow;
@end
