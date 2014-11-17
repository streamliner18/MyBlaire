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

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleErrorBlock:(MBApiErrorBlock)block
{
    [[MBApiWebManager shareWithoutToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block([MBApiError shareNetworkError]);
    }];
}

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleArrayBlock:(MBApiArrayBlock)block
{
    [[MBApiWebManager shareWithoutToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]], [(NSDictionary *)responseObject arrayForKey:@"result"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block([MBApiError shareNetworkError],nil);
    }];
}


+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password email:(NSString *)mail handle:(MBApiErrorBlock)block
{
    if ([self checkEmail:mail]) {
        [self postWithTokenURL:@"MyBlaire/app/register" parameters:@{@"userName":userName,@"password":password,@"email":mail} handleErrorBlock:^(MBApiError *error) {
            block(error);
        }];
    }else{
        block([MBApiError shareWithCode:MBApiCodeRegisterFaildWithEmailError message:@"邮箱填写错误"]);
    }
}

+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiErrorBlock)block
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

+ (void)getKeyWordWithCompletionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/getKeyWord";
    NSDictionary *param = nil;
    [self postWithTokenURL:url parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getHotGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/getHotGoods";
    NSDictionary *param = nil;
    [self postWithTokenURL:url parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getStreetShootingGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/getStreetShootingGoods";
    NSDictionary *param = nil;
    [self postWithTokenURL:url parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getGoodsWithPriceRange:(MBGoodsPriceRange)range discount:(MBGoodsDiscount)discount color:(NSString *)color searchContent:(NSString *)content completionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/getGoods";
    NSDictionary *param = @{@"priceRange":[NSString stringWithFormat:@"%ld",(long)range],@"discount":@(discount),@"color":color,@"searchContent":content};
    [self postWithTokenURL:url parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getGoodsInfo:(NSInteger)goodsID completionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/getGoodDetailed";
    NSDictionary *param = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:url parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)collecteGoods:(NSInteger)goodsID completionHandle:(MBApiErrorBlock)block
{
    NSString *url = @"MyBlaire/app/collectGood";
    NSDictionary *parems = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:url parameters:parems handleErrorBlock:^(MBApiError *error) {
        block(error);
    }];
}

+ (void)collectOrderGoodCompletionHandle:(MBApiArrayBlock)block
{
    NSString *url = @"MyBlaire/app/collectOrder";
    NSDictionary *parems = nil;
    [self postWithTokenURL:url parameters:parems handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)feedbackWithMesage:(NSString *)message completionHandle:(MBApiErrorBlock)block
{
    NSString *url = @"MyBlaire/app/saveFeedback";
    NSDictionary *parems = @{@"content":message};
    [self postWithTokenURL:url parameters:parems handleErrorBlock:^(MBApiError *error) {
        block(error);
    }];
}

+ (BOOL)checkEmail:(NSString *)mail
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:mail];
}

@end
