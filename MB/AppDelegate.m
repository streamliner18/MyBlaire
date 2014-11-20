//
//  AppDelegate.m
//  MB
//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "TTXTransitionManager.h"
#import "MBSocialManager.h"
#import "TTXBaseNavigationController.h"
#import "MBHomePageViewController.h"
#import "MBSearchViewController.h"
#import "MBLoveViewController.h"
#import "MBAboutViewController.h"

#import "MBModel.h"

#import "MBApi.h"

#import <AFNetworkActivityLogger.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    if (DEBUG) [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    MB_Model;
    
    //设定Tabbar的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil]forState:UIControlStateSelected];
    if (iOS7) {
        [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    }
    /////
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [TTXTransitionManager validatePanPackWithTransitionGestureRecognizerType:TransitionGestureRecognizerTypePan];
    [MBSocialManager registSocialShare];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBHomePageViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBSearchViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBLoveViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBAboutViewController alloc] init]]
                            ];
    self.window.rootViewController = tab;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];    
    return YES;
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [MBSocialManager application:application openURL:url sourceApplication:sourceApplication annotation:annotation];;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [MB_Model clear];
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
