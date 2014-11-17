//
//  MBSocialManager.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocial.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaHandler.h>
#import <UMSocialWechatHandler.h>

@interface MBSocialManager : NSObject

+ (void)registSocialShare;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
