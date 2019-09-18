//
//  NSString+ZBase64.m
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import "NSString+ZBase64.h"
#import "NSData+ZBase64.h"

@implementation NSString (ZBase64)
+ (NSString *)z_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData z_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)z_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data z_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)z_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data z_base64EncodedString];
}
- (NSString *)z_base64DecodedString
{
    return [NSString z_stringWithBase64EncodedString:self];
}
- (NSData *)z_base64DecodedData
{
    return [NSData z_dataWithBase64EncodedString:self];
}
@end
