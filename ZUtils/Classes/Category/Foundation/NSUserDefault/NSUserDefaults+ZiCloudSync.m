//
//  NSUserDefaults+ZiCloudSync.m
//  Pods
//
//  Created by zwx on 2017/11/16.
//

#import "NSUserDefaults+ZiCloudSync.h"

@implementation NSUserDefaults (ZiCloudSync)

+(void)z_setObject:(id)value forKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+(void)z_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSUbiquitousKeyValueStore* iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
    if (sync) {
        [iCloudStore setObject:value forKey:key];
        [iCloudStore synchronize];
    }

}

+(id)z_objectForKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+(id)z_objectForKey:(NSString *)key iCloudSync:(BOOL)sync
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSUbiquitousKeyValueStore* iCloudStore = [NSUbiquitousKeyValueStore defaultStore];

    if (sync) {
        //Get value from iCloud
        id value = [iCloudStore objectForKey:key];
        
        //Store to NSUserDefault and synchronize
        [defaults setObject:value forKey:key];
        [defaults synchronize];
        
        return value;
    }
    return [defaults objectForKey:key];
}

+(void) z_removeObjectForKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+(void)z_removeObjectForKey:(NSString *)key iCloudSync:(BOOL)sync
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSUbiquitousKeyValueStore* iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    if (sync){
        [iCloudStore removeObjectForKey:key];
        [iCloudStore synchronize];
    }
    
    [defaults removeObjectForKey:key];
    [defaults synchronize];
    
}

+(BOOL)z_synchronize
{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)z_synchronizeAlsoiCloudSync:(BOOL)sync
{
    BOOL res = true;
    
    if (sync)
        res &= [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    res &= [[NSUserDefaults standardUserDefaults] synchronize];
    return res;
}


@end
