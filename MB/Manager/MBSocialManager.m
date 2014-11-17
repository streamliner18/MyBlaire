//
//  MBSocialManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSocialManager.h"

@implementation MBSocialManager

+ (void)registSocialShare
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

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

@end
