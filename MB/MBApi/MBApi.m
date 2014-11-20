//
//  MBApi.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBApi.h"
#import "MBApiWebManager.h"

typedef NS_ENUM(NSUInteger, MBApiPostType) {
    MBApiPostTypeRegister,//注册
    MBApiPostTypeLoginNormal,//正常登录
    MBApiPostTypeLoginThirdParty,//第三方登录
    MBApiPostTypeGetKeyWord,//关键词
    MBApiPostTypeGetHotGoods,//热销产品
    MBApiPostTypeGetStreetShootingGoods,//明星同款
    MBApiPostTypeGetGoodsWithCondition,//条件搜索
    MBApiPostTypeGetGoodsInfo,//查看商品信息
    MBApiPostTypeCollecteGoods,//收藏商品
    MBApiPostTypeGetCollecteOrderGoods,//获取收藏的商品
    MBApiPostTypeFeedback,//反馈
};

typedef void(^MBApiPostBlock)(MBApiError *error,NSArray *array);

@implementation MBApi

#pragma mark - Base Post Request

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleErrorBlock:(MBApiPostBlock)block
{
    if (url && url.length > 0) {
        [[MBApiWebManager shareWithoutToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]],nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError],nil);
        }];
    }
}

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleArrayBlock:(MBApiPostBlock)block
{
    if (url && url.length > 0) {
        [[MBApiWebManager shareWithToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]], [(NSDictionary *)responseObject arrayForKey:@"result"]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError],nil);
        }];
    }
}

#pragma mark - functions

+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password email:(NSString *)mail handle:(MBApiErrorBlock)block
{
    if ([self checkEmail:mail]) {
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeRegister] parameters:@{@"userName":userName,@"password":password,@"email":mail} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block ([self dealWithRegisterSuccessResult:responseObject]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block ([MBApiError shareNetworkError]);
        }];
    }else{
        block([MBApiError shareWithCode:MBApiCodeRegisterFaildWithEmailError message:@"邮箱填写错误"]);
    }
}

+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiErrorBlock)block
{
    if (type == MBLoginTypeNormal) {
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeLoginNormal] parameters:@{@"userName":userName,@"password":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block ([self dealWithLoginSuccessResult:responseObject]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block ([MBApiError shareNetworkError]);
        }];
    }else{
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeLoginThirdParty] parameters:@{@"thirdPartyType":(type == MBLoginTypeQQ ? @"QQ":@"MICROBLOG"),@"thirdPartyToken":token} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block ([self dealWithLoginSuccessResult:responseObject]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block ([MBApiError shareNetworkError]);
        }];
    }
}

+ (void)getKeyWordWithCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetKeyWord] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getHotGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetHotGoods] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getStreetShootingGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetStreetShootingGoods] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getGoodsWithPriceRange:(MBGoodsPriceRange)range discount:(MBGoodsDiscount)discount color:(NSString *)color searchContent:(NSString *)content completionHandle:(MBApiArrayBlock)block
{
    NSMutableDictionary *param = @{}.mutableCopy;
    if (range != MBGoodsConditionNoRange) {
        [param setObject:[NSString stringWithFormat:@"%ld",(long)range] forKey:@"priceRange"];
    }
    if (discount != MBGoodsDiscountNoneLimit) {
        [param setObject:@(discount) forKey:@"discount"];
    }
    [param setValue:content forKey:@"searchContent"];
    [param setValue:color forKey:@"color"];
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetGoodsWithCondition] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)getGoodsInfo:(NSInteger)goodsID completionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetGoodsInfo] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)collecteGoods:(NSInteger)goodsID completionHandle:(MBApiErrorBlock)block
{
    NSDictionary *parems = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeCollecteGoods] parameters:parems handleErrorBlock:^(MBApiError *error, NSArray *array) {
        block(error);
    }];
}

+ (void)collectOrderGoodCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *parems = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetCollecteOrderGoods] parameters:parems handleArrayBlock:^(MBApiError *error, NSArray *array) {
        block(error,array);
    }];
}

+ (void)feedbackWithMesage:(NSString *)message completionHandle:(MBApiErrorBlock)block
{
    NSDictionary *parems = @{@"content":message};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeFeedback] parameters:parems handleErrorBlock:^(MBApiError *error, NSArray *array) {
        block(error);
    }];
}

#pragma mark - 功能性url

+ (NSString *)urlWithPostType:(MBApiPostType)type
{
    NSString *url = nil;
    switch (type) {
        case MBApiPostTypeRegister:
            url = @"MyBlaire/app/register";
            break;
        case MBApiPostTypeLoginNormal:
            url = @"MyBlaire/app/normalLogin";
            break;
        case MBApiPostTypeLoginThirdParty:
            url = @"MyBlaire/app/thirdPartyLogin";
            break;
        case MBApiPostTypeFeedback:
            url = @"MyBlaire/app/saveFeedback";
            break;
        case MBApiPostTypeGetCollecteOrderGoods:
            url = @"MyBlaire/app/collectOrder";
            break;
        case MBApiPostTypeCollecteGoods:
            url = @"MyBlaire/app/collectGood";
            break;
        case MBApiPostTypeGetGoodsInfo:
            url = @"MyBlaire/app/getGoodDetailed";
            break;
        case MBApiPostTypeGetHotGoods:
            url = @"MyBlaire/app/getHotGoods";
            break;
        case MBApiPostTypeGetGoodsWithCondition:
            url = @"MyBlaire/app/getGoods";
            break;
        case MBApiPostTypeGetStreetShootingGoods:
            url = @"MyBlaire/app/getStreetShootingGoods";;
            break;
        case MBApiPostTypeGetKeyWord:
            url = @"MyBlaire/app/getKeyWord";
            break;
        default:
            break;
    }
    return url;
}

#pragma mark - 检查邮箱

+ (BOOL)checkEmail:(NSString *)mail
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:mail];
}

#pragma mark - 处理注册的结果

+ (MBApiError *)dealWithRegisterSuccessResult:(NSDictionary *)responseObject
{
    return [MBApiError shareWithCode:[responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]];
}

#pragma mark - 处理登录的结果

+ (MBApiError *)dealWithLoginSuccessResult:(NSDictionary *)responseObject
{
    MBApiError *error = [MBApiError shareWithDictionary:responseObject];
    if (error.code == MBApiCodeSuccess) {
        [[NSUserDefaults standardUserDefaults] setObject:[[responseObject dictionaryForKey:@"result"] stringForKey:@"token"] forKey:@"MBTOKEN"];
    }
    return error;
}


@end
