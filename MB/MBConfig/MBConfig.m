//
//  MBConfig.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBConfig.h"

NSString* TTX_ShowGuide_AppVersion(void)
{
    return @"1.0.0";
}

NSString *TTX_AppVersion(NSString *version)
{
    return [@"TTX" stringByAppendingString:version];
}

BOOL TTX_AppVersion_Is_FirstLoad(NSString *version)
{
    return NO;
//    return ![[NSUserDefaults standardUserDefaults] boolForKey:TTX_AppVersion(version)];
}

NSString* MB_ShouldHideLaunchView(void)
{
    return @"NotificationKey_ShouldHideLaunchView";
}