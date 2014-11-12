//
//  AppDelegate.m
//  MB
//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewManager.h"
#import "TTXTransitionManager.h"
#import <UMSocial.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaHandler.h>
#import <UMSocialWechatHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TTXTransitionManager validatePanPackWithTransitionGestureRecognizerType:TransitionGestureRecognizerTypePan];
    [self registSocialShare];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    [GuideViewManager showGuildWithAppVersion:TTX_ShowGuide_AppVersion()];
    return YES;
}

- (void)registSocialShare
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:kUmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:NO];
    
    [UMSocialWechatHandler setWXAppId:kIMWechatAppKey appSecret:kIMWechatAppSecret url:kIMWechatAppRedirectUrl];
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:kSnsSinaWeiboRedirectUrl];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
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

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
