//
//  NSUserDefaults+ZiCloudSync.h
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import <Foundation/Foundation.h>


/**
 持久化保存 并 同步 iCould(自动调用了 synchronize)
 */
@interface NSUserDefaults (ZiCloudSync)

+(void)z_setObject:(id)value forKey:(NSString *)key;
+(void)z_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

+(id)z_objectForKey:(NSString *)key;
+(id)z_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

+(void)z_removeObjectForKey:(NSString *)key;
+(void)z_removeObjectForKey:(NSString *)key iCloudSync:(BOOL)sync;

+(BOOL)z_synchronize;
+(BOOL)z_synchronizeAlsoiCloudSync:(BOOL)sync;

@end
