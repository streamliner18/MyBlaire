//
//  AppDelegate.m
//  MB
//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "MLBlackTransition.h"
#import "MBSocialManager.h"
#import "TTXBaseNavigationController.h"
#import "MBHomePageViewController.h"
#import "MBSearchViewController.h"
#import "MBLoveViewController.h"
#import "MBAboutViewController.h"
#import <FIR/FIR.h>

#import "MBModel.h"

#import "MBApi.h"

//#import <AFNetworkActivityLogger.h>
#import <AFNetworkActivityIndicatorManager.h>


#import "UIImage+color.h"

#import "LaunchView.h"
#import "MBNewSortView.h"
#import "MBSorter.h"

#import "MBSortViewController.h"

#import "UIFont+Replacement.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIR handleCrashWithKey:@"7756b081c3b65e906e4db4a861f30171"]; 
    [UIFont setReplacementDictionary:@{
                                       @"Helvetica" : @"QuicksandBook-Regular",
                                       @"Helvetica-Bold":@"QuicksandBold-Regular",
                                       @"HelveticaNeueInterface-Italic" : @"QuicksandBookOblique-Regular"
                                       }];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [MBSta registSta];
    
//    if (DEBUG) [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    MB_Model;
    
    [[MBSorter shared] buildSorters];
    if (kiOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [[UITabBar appearance] setBarStyle:UIBarStyleDefault];
        [[UITabBar appearance] setTranslucent:NO];
        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.window.width, 49)]];
    }
    //设定Tabbar的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#6c6c6c"], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#6c6c6c"],UITextAttributeTextColor, nil]forState:UIControlStateNormal];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    UIFont* font = [UIFont systemFontOfSize:18];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#434a54"]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.window.width, kiOS7?64:44)] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor]}];
    /////
    
    [MLBlackTransition validatePanPackWithMLBlackTransitionGestureRecognizerType:MLBlackTransitionGestureRecognizerTypePan];
    [MBSocialManager registSocialShare];
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBHomePageViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBSearchViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBLoveViewController alloc] init]],
                            [[TTXBaseNavigationController alloc] initWithRootViewController:[[MBAboutViewController alloc] init]]
                            ];
    MMDrawerController *menu = [[MMDrawerController alloc] initWithCenterViewController:tab leftDrawerViewController:[[MBSortViewController alloc] init]];
    menu.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    menu.maximumLeftDrawerWidth = self.window.width - 50;
    self.window.rootViewController = menu;
    LaunchView *launchView = [[LaunchView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window addSubview:launchView];
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
//    [MB_Model clear];
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
