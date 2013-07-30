//
//  AppDelegate.m
//  tmipushproject
//
//  Created by 吳其哲 on 13/7/29.
//  Copyright (c) 2013年 JerruWu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //判斷是否由遠程消息通知觸發應用程序启動
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //獲取應用程序消息通知標記數（即小紅圈中的數字）
        int badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果應用程序消息通知標記數（即小紅圈中的數字）大於0，清除標記。
            badge--;
            //清除標記。清除小紅圈中數字，小紅圈中數字为0，小紅圈才會消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }

    //啟動推播服務
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
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



- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    NSString *tokenStr = [deviceToken description];
    NSString *pushToken = [[tokenStr
                             stringByReplacingOccurrencesOfString:@"" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 將所收到的 device token 資料傳到 APN Server
    NSLog(@"%@",pushToken);
    

}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /* 把收到的推播列舉出來 */
    for (id key in userInfo) {
        NSLog(@"Key=[%@], Value=[%@]", key, [userInfo objectForKey:key]);
    }
    
    /* 印出 Badge number */
    NSLog(@"Badge: %@", [[userInfo objectForKey:@"aps"] objectForKey:@"badge"]);
    NSLog(@"Receive remote notification : %@",userInfo);
}


@end
