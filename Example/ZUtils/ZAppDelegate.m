//
//  ZAppDelegate.m
//  ZUtils
//
//  Created by zhwx600 on 11/16/2017.
//  Copyright (c) 2017 zhwx600. All rights reserved.
//

#import "ZAppDelegate.h"


@implementation ZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSDate date] z_week];

    [AFHttpClient setServerHost:@"http://apijson.cn"];
    [AFHttpClient setServerTempPath:nil];
    
    BOOL isCN = [ZLanguage isCN];
    ZLStr_KT(@"rwer", @"wer");
    ZLStr_K(@"234");
    ZLStr_K(@"");

    
//#define STATUS_HEIGHT (IS_FULL_SCREEN ? [UIDevice z_statusBarHeight] : 20.f)
//#define NAVBAR_HEIGHT 44.f
//#define TABBAR_HEIGHT ([UIDevice z_tabBarFullHeight])
//#define TABBAR_SafeBottomMargin ([UIDevice z_safeDistanceBottom])
//#define STATUS_AND_NAVBAR_HEIGHT ([UIDevice z_navigationFullHeight])
    
    
    ZLLog(@"--%f-----*1",STATUS_HEIGHT);
    ZLLog(@"--%f-----*2",TABBAR_HEIGHT);
    ZLLog(@"--%f-----*3",TABBAR_SafeBottomMargin);
    ZLLog(@"--%f-----*4",STATUS_AND_NAVBAR_HEIGHT);
    
    
    [[AFHttpClient sharedClient] getUrl:@"https://api.apiopen.top/getAllUrl" param:nil success:^(id json) {
        
        ZLLog(@"234234%@",@"haha");
        
    } failure:^(NSError *error) {
        
    } processView:nil];
    
    
//    NSDate* datett = nil;
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
