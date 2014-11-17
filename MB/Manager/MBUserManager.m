//
//  MBUserManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBUserManager.h"

#define k_MBUSERMANAGER_DEFAULT_KEY @"MBUSERMANAGER_DEFAULT_KEY"

@implementation MBUserManager

+(BOOL)userHasLogined
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:k_MBUSERMANAGER_DEFAULT_KEY];
}

+ (BOOL)showGuideView
{
    if ([self userHasLogined]) {
        return NO;
    }else{
        [GuideViewManager showGuildWithAppVersion:TTX_ShowGuide_AppVersion()];
        return YES;
    }
}

@end
