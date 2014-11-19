//
//  MBModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBModel.h"

@implementation MBModel

#define kMBMODELTOKENKEY @"MBTOKEN"

+ (instancetype)shared
{
    static MBModel *userModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userModel = [[self alloc] init];
        [userModel configSelf];
        [userModel registNotification];
    });
    return userModel;
}

- (void)configSelf
{
    self.token = [[NSUserDefaults standardUserDefaults] stringForKey:kMBMODELTOKENKEY];
    if (self.token) {
        DLog(@"%@",self.token);
    }
}

- (void)registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin:) name:kMBMODELUSERDIDLOGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLoginOut:) name:KMBMODELUSERDIDLOGINOUT object:nil];
}

- (void)userDidLogin:(NSNotification *)sender
{
    [self configSelf];
}

- (void)userDidLoginOut:(NSNotification *)sender
{
    [self configSelf];
}

- (void)save
{
    [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:kMBMODELTOKENKEY];
}

- (void)clear
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMBMODELTOKENKEY];
    [self configSelf];
}

@end
