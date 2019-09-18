//
//  NSString+ZEncrypt.m
//  Pods
//
//  Created by zwx on 2017/11/21.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes

#import "NSString+ZEncrypt.h"
#import "NSData+ZEncrypt.h"
#import "NSData+ZBase64.h"

@implementation NSString (ZEncrypt)
-(NSString*)z_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] z_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted z_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)z_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData z_dataWithBase64EncodedString:self] z_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)z_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] z_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted z_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)z_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData z_dataWithBase64EncodedString:self] z_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)z_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] z_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted z_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)z_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData z_dataWithBase64EncodedString:self] z_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}
@end
