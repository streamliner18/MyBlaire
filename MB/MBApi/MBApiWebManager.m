//
//  MBApiWebManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBApiWebManager.h"

@implementation MBApiWebManager

+ (instancetype)shared
{
    static MBApiWebManager * s_sharedWebManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:MBURLBASE];
        s_sharedWebManager = [[self alloc] initWithBaseURL:baseURL];
        s_sharedWebManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return s_sharedWebManager;
}

+ (instancetype)shareWithToken
{
    MBApiWebManager *manager = [self shared];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"MBTOKEN"] forHTTPHeaderField:@"token"];
    return manager;
}

+ (instancetype)shareWithoutToken
{
    MBApiWebManager *manager = [self shared];
    [manager.requestSerializer setValue:nil forHTTPHeaderField:@"token"];
    return manager;
}

@end
