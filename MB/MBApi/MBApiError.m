//
//  MBApiError.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBApiError.h"

@implementation MBApiError
+ (instancetype)shareWithCode:(MBApiCode)code message:(NSString *)message
{
    MBApiError *error = [[MBApiError alloc] init];
    error.code = code;
    error.message = message;
    return error;
}
+ (instancetype)shareNetworkError
{
    return [MBApiError shareWithCode:MBApiCodeNetworkError message:@"网络连接错误"];
}

+ (instancetype)shareWithDictionary:(NSDictionary *)dic
{
    MBApiError *error = [[MBApiError alloc] init];
    error.code = [dic integerForKey:@"code"];
    error.message = [dic stringForKey:@"message"];
    return error;
}
@end
