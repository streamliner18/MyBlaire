//
//  MBModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBModel.h"

@implementation MBModel
SINGLETON_IMPLEMENTATION(MBModel)

+ (void)regist
{
    NSURL *baseURL = [NSURL URLWithString:MBURLBASE];
    AFHTTPRequestOperationManager *s_sharedWebAPIManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSDictionary *param = @{@"userName":@"xushao1990",@"password":@"xu123456789",@"email":@"1124672787@qq.com"};    
//    [s_sharedWebAPIManager.requestSerializer setValue:uuidString forHTTPHeaderField:@"Vacation-device-id"];
    [s_sharedWebAPIManager POST:@"MyBlaire/app/register" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

@end
