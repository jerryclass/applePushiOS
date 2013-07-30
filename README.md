applePushiOS
============

apple push 範例程式


主要需要新增以下三個部分


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

