//
//  MBApi.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBApi.h"
#import "MBApiWebManager.h"

@implementation MBApi
+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password email:(NSString *)mail handle:(MBApiRegisterBlock)block
{
    if ([self checkEmail:mail]) {
        [[MBApiWebManager shareWithoutToken] POST:@"MyBlaire/app/register" parameters:@{@"userName":userName,@"password":password,@"email":mail} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError]);
        }];
    }else{
        block([MBApiError shareWithCode:MBApiCodeRegisterFaildWithEmailError message:@"邮箱填写错误"]);
    }
}

+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiLoginBlock)block
{
    if (type == MBLoginTypeNormal) {
        [[MBApiWebManager shareWithoutToken] POST:@"MyBlaire/app/normalLogin" parameters:@{@"userName":userName,@"password":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]]);
            if ([(NSDictionary *)responseObject integerForKey:@"code"] == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:[[(NSDictionary *)responseObject dictionaryForKey:@"result"] stringForKey:@"token"] forKey:@"MBTOKEN"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError]);
        }];
    }else{
        [[MBApiWebManager shareWithoutToken] POST:@"MyBlaire/app/thirdPartyLogin" parameters:@{@"thirdPartyType":(type == MBLoginTypeQQ ? @"QQ":@"MICROBLOG"),@"thirdPartyToken":token} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]]);
            if ([(NSDictionary *)responseObject integerForKey:@"code"] == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:[[(NSDictionary *)responseObject dictionaryForKey:@"result"] stringForKey:@"token"] forKey:@"MBTOKEN"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError]);
        }];
    }
}

+ (void)getKeyWord
{
    [[MBApiWebManager shareWithToken] POST:@"MyBlaire/app/getKeyWord" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

+ (BOOL)checkEmail:(NSString *)mail
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:mail];
}

@end
