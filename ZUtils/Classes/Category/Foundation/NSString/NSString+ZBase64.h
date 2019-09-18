//
//  NSString+ZBase64.h
//  Pods
//
//  Created by zwx on 2017/11/21.
//

#import <Foundation/Foundation.h>

@interface NSString (ZBase64)
+ (NSString *)z_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)z_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)z_base64EncodedString;
- (NSString *)z_base64DecodedString;
- (NSData *)z_base64DecodedData;
@end
