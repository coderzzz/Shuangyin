//
//  AppDelegate.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"
#import "PageVC.h"
#import "LoginService.h"
#import "RightViewController.h"
#import "CustomUserGuideScrollView.h"
#import "LoginService.h"

#define IsNotFirstLaunched @"IsNotFirstLaunched"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//  
//    [MobClick startWithAppkey:MobKey];
 
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"ExamModel.sqlite"];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([[LoginService shareInstanced]isLogined]) {
    
        self.ddmenu = [[DDMenuController alloc]init];
        
        TabBarViewController *rootvc = [[TabBarViewController alloc] init];
        
        RightViewController *rig = [[RightViewController alloc]init];
        
        self.ddmenu.rightViewController = rig;
        self.ddmenu.rootViewController = rootvc;
        
        self.window.rootViewController =  self.ddmenu;
        
        PersonModel *model = [[LoginService shareInstanced]getUserModel];
        
        [[LoginService shareInstanced]getUserDetailWithID:model.use.ftoken];

        
    }
    else{
        
        LoginViewController *vc = [[LoginViewController alloc]init];
        BaseNavigationController *ba = [[BaseNavigationController alloc]initWithRootViewController:vc];
        
        self.window.rootViewController = ba;
        
    }

    if(![[NSUserDefaults standardUserDefaults] boolForKey:IsNotFirstLaunched])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsNotFirstLaunched];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self showUserGuide];
    }
    
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"599bf1ce82b63512ed00036d"];
    
    [self configUSharePlatforms];
    
    [self.window makeKeyAndVisible];
    
    
    
    
   
    //向微信注册
//    [WXApi registerApp:APP_ID withDescription:@"iwen"];
    
//    [[ShareManager sharePlatform]configShare];
    
    return YES;
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd2adeee83b0f9771" appSecret:@"aa8a862d105dadc32a524b17b8d30a5f" redirectURL:nil];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxd2adeee83b0f9771" appSecret:@"aa8a862d105dadc32a524b17b8d30a5f" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //
    //    /*
    //     设置新浪的appKey和appSecret
    //     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
    //     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}



- (void)showUserGuide
{
    
    
//    NSMutableArray * imageNames = [@[@"",@"",@"",@""] mutableCopy];
//    NSString * subfix = @"4s";
//    if([OSHelper iPhone4] || [OSHelper iPad])
//    {
//        subfix = @"4s";
//    }
//    else if([OSHelper iPhone5])
//    {
//        subfix = @"5s";
//    }
//    else if ([OSHelper iPhone6])
//    {
//        subfix = @"6";
//    }
//    else if([OSHelper iPhone6s])
//    {
//        subfix = @"6s";
//    }
//    int count = (int)[imageNames count];
//    for(int i = 0; i < count; i++)
//    {
//        NSString * str = imageNames[i];
//        [imageNames replaceObjectAtIndex:i withObject:[str stringByAppendingString:subfix]];
//    }
    
    CustomUserGuideScrollView * guideView = [[CustomUserGuideScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageNames:@[@"发ff",@"抢元宝11",@"抢红包11"] isShowPage:YES];
   
    [self.window.rootViewController.view addSubview:guideView];
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;

    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WxPay" object:@"1"];
                
                break;
                
            default:
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WxPay" object:@"0"];
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
  
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



//- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation{
//    
//    
//    NSLog(@"%ld",(long)oldStatusBarOrientation);
//}

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    
//    
//    
//}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    
    if ([self.player isEqualToString:@"play"]) {
        
        return UIInterfaceOrientationMaskAll;
    }
    else{
        
        return UIInterfaceOrientationMaskPortrait;
        
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
    [MagicalRecord cleanUp];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
