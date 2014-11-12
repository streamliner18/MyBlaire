//
//  GuideViewManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "GuideViewManager.h"
#import "MBGuideViewController.h"
#import "TTXBaseNavigationController.h"
#import "MBLoginViewController.h"

@implementation GuideViewManager
+ (void)showGuildWithAppVersion:(NSString *)version
{
    if (TTX_AppVersion_Is_FirstLoad(version)) {
        MBGuideViewController *guideView = [[MBGuideViewController alloc] init];
        [GuideViewManager configGuideViewAction:guideView];
        UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [controller presentViewController:[[TTXBaseNavigationController alloc] initWithRootViewController:guideView] animated:YES completion:nil];
    }
}

+ (void)configGuideViewAction:(MBGuideViewController *)guideView
{
    @weakify(guideView);
    guideView.loginActionBlock = ^(){
        @strongify(guideView);
        MBLoginViewController *loginViewController = [[MBLoginViewController alloc] init];
        [guideView.navigationController pushViewController:loginViewController animated:YES];
        [GuideViewManager configLoginViewAction:loginViewController];
    };
    guideView.registActionBlock = ^(){

    };
}

+ (void)configLoginViewAction:(MBLoginViewController *)loginView
{
    @weakify(loginView);
    loginView.sinaLoginActionBlock = ^(){
        NSLog(@"1");
    };
    loginView.qqLoginActionBlock = ^(){
        NSLog(@"0");

    };
}

@end
