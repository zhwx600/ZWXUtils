//
//  NSString+ZNet.m
//  Pods
//
//  Created by zwx on 2017/11/24.
//

#import "NSString+ZNet.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <UIKit/UIKit.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation NSString(ZNet)

+(NSString*) z_getPublicNetworkIp
{
    NSURL *url = [NSURL URLWithString:@"http://ip.3322.org/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:1.0f];
    NSHTTPURLResponse *response;
    //返回的是GBK编码
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if (200 == [response statusCode]) {
        
        NSString *ip = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        ip = [ip stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
        
        return ip;
    }else{
        return nil;
    }
    
}


/**
 * 获取本机的 外网IP  http://www.ip.cn/
 */
+(NSString*) z_getPublicNetworkIp2
{
    NSURL *url = [NSURL URLWithString:@"http://www.ip.cn/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:1.0f];
    NSHTTPURLResponse *response;
    //返回的是GBK编码
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if (200 == [response statusCode]) {
        
        //utf8
        NSString *gbkNSString2 = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        NSRange range1 = [gbkNSString2 rangeOfString:@"data-title=\""];
        NSRange range2 = [gbkNSString2 rangeOfString:@"\" data-url="];
        
        if (range1.length<=0 || range2.length<=0) {
            return nil;
        }
        
        NSString* ipStr = [gbkNSString2 substringWithRange:NSMakeRange(range1.location+range1.length, range2.location - (range1.location+range1.length))];
        ipStr = [ipStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
        
        return ipStr;
        
    }else{
        return nil;
    }
    
}

/**
 * 获取本机的 外网IP http://www.ip38.com/
 */
+(NSString*) z_getPublicNetworkIp3
{
    NSURL *url = [NSURL URLWithString:@"http://www.ip38.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:1.0f];
    NSHTTPURLResponse *response;
    //返回的是GBK编码
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if (200 == [response statusCode]) {
        
        //  GBK编码 (通过CFStringConvertEncodingToNSStringEncoding转码)
        NSStringEncoding nsEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *gbkNSString2 = [[NSString alloc] initWithData:returnData encoding:nsEncoding];
        
        NSRange range1 = [gbkNSString2 rangeOfString:@"您的本机IP地址："];
        NSRange range2 = [gbkNSString2 rangeOfString:@"&nbsp;&nbsp;来自："];
        
        if (range1.length<=0 || range2.length<=0) {
            return nil;
        }
        
        NSString* ipStr = [gbkNSString2 substringWithRange:NSMakeRange(range1.location+range1.length, range2.location - (range1.location+range1.length))];
        ipStr = [ipStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
        
        return ipStr;
        
    }else{
        return nil;
    }
}


/**
 * 获取本机的内网IP
 */
+ (NSString *)z_getIPAddressWithIsIp4:(BOOL)isIPv4
{
    NSArray *searchArray = isIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self z_getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

/**
 * 获取本机的内网IP
 */
+ (NSDictionary *)z_getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}



/**
 * 获取一个自动增长的 unsigned short
 */
+(unsigned short) z_getAddShortValue
{
    static unsigned short addValue = 0;
    
    unsigned short returnValue = addValue;
    
    //超过 65535 则变为0
    addValue = (addValue+1)%(0xFFFF+1);
    
    return returnValue;
}



/**
 * 测试是否是 大端 在前
 */
+(BOOL) z_isBitEndianTest
{
    /*定义一个2个字节长度的数据，并赋值为1,则n的16进制表示为0x0001
     如果系统以“大端”存放数据，也即是以MSB方式存放，那么低字节存放的必定是0x00，高字节存放的必定是0x01
     如果系统以“小端”存放数据，也即是以LSB方式存放，那么低字节存放的必定是0x01，高字节存放的必定是0x00
     所谓MSB，就是将最重要的位存入低位，而LSB则是将最不重要的位存入低位
     我们可以通过检测低位的数值就可以知道系统的字节序
     */
    const int16_t n = 1;
    if(*(char *)&n)
    {
        return NO;
    }
    return YES;
}



/**
 * 交换 short 高低字节序
 */
+(short) z_swap16WithShort:(short)value
{
    return ((((value) & 0xff) << 8) | (((value) >> 8) & 0xff));
}

/**
 * 交换 int 高低字节序
 */
+(int) z_swap32WithInt:(int)value
{
    return  (((value) >> 24)
             | (((value) & 0x00ff0000) >> 8)
             | (((value) & 0x0000ff00) << 8)
             | ((value) << 24));
}

/**
 * 交换 long long 高低字节序
 */
+(long long) z_swap64WithLongLong:(long long)value
{
    return (((value) >> 56)
            | (((value) & 0x00ff000000000000) >> 40)
            | (((value) & 0x0000ff0000000000) >> 24)
            | (((value) & 0x000000ff00000000) >> 8)
            | (((value) & 0x00000000ff000000) << 8)
            | (((value) & 0x0000000000ff0000) << 24)
            | (((value) & 0x000000000000ff00) << 40)
            | (((value) << 56)));
}


/**
 * 是否显示 加载网络(系统)
 */
+(void) z_showNetWorkIcon:(bool)bShow
{
    UIApplication *app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=bShow;
}

@end
