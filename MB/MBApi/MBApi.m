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
    MBApiPostTypeRegister,
    MBApiPostTypeLoginNormal,
    MBApiPostTypeLoginThirdParty,
    MBApiPostTypeGetKeyWord,
    MBApiPostTypeGetHotGoods,
    MBApiPostTypeGetStreetShootingGoods,
    MBApiPostTypeGetGoodsWithCondition,
    MBApiPostTypeGetGoodsInfo,
    MBApiPostTypeCollecteGoods,
    MBApiPostTypeGetCollecteOrderGoods,
    MBApiPostTypeFeedback,
};

typedef void(^MBApiPostBlock)(MBApiError *error,NSArray *array,id responseObject);

@implementation MBApi

#pragma mark - Base Post Request

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleErrorBlock:(MBApiPostBlock)block
{
    if (url && url.length > 0) {
        [[MBApiWebManager shareWithoutToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]],nil,responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError],nil,nil);
        }];
    }
}

+ (void)postWithTokenURL:(NSString *)url parameters:(NSDictionary *)dic handleArrayBlock:(MBApiPostBlock)block
{
    if (url && url.length > 0) {
        [[MBApiWebManager shareWithoutToken] POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]], [(NSDictionary *)responseObject arrayForKey:@"result"],responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block([MBApiError shareNetworkError],nil,nil);
        }];
    }
}

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

#pragma mark - function

+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password email:(NSString *)mail handle:(MBApiErrorBlock)block
{
    if ([self checkEmail:mail]) {
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeRegister] parameters:@{@"userName":userName,@"password":password,@"email":mail} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            block([MBApiError shareWithCode:[(NSDictionary *)responseObject integerForKey:@"code"] message:[(NSDictionary *)responseObject stringForKey:@"message"]]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (operation.responseData) {
                NSDictionary *dic;
                if ((dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil])) {
                    block([MBApiError shareWithDictionary:dic]);
                }
            }else{
                block([MBApiError shareNetworkError]);
            }
        }];
    }else{
        block([MBApiError shareWithCode:MBApiCodeRegisterFaildWithEmailError message:@"邮箱填写错误"]);
    }
}

+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiErrorBlock)block
{
    if (type == MBLoginTypeNormal) {
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeLoginNormal] parameters:@{@"userName":userName,@"password":password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                MBApiError *error = [MBApiError shareWithDictionary:responseObject];
                if (error.code == MBApiCodeLoginSuccess) {
                    [[NSUserDefaults standardUserDefaults] setObject:[[(NSDictionary *)responseObject dictionaryForKey:@"result"] stringForKey:@"token"] forKey:@"MBTOKEN"];
                }
                block(error);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (operation.responseData) {
                NSDictionary *dic;
                if ((dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil])) {
                    MBApiError *error = [MBApiError shareWithDictionary:dic];
                    if (error.code == MBApiCodeLoginSuccess) {
                        [[NSUserDefaults standardUserDefaults] setObject:[[dic dictionaryForKey:@"result"] stringForKey:@"token"] forKey:@"MBTOKEN"];
                    }
                    block(error);
                }
            }else{
                block([MBApiError shareNetworkError]);
            }
        }];
    }else{
        [[MBApiWebManager shareWithoutToken] POST:[self urlWithPostType:MBApiPostTypeLoginThirdParty] parameters:@{@"thirdPartyType":(type == MBLoginTypeQQ ? @"QQ":@"MICROBLOG"),@"thirdPartyToken":token} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetKeyWord] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)getHotGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetHotGoods] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)getStreetShootingGoodsWithCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetStreetShootingGoods] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)getGoodsWithPriceRange:(MBGoodsPriceRange)range discount:(MBGoodsDiscount)discount color:(NSString *)color searchContent:(NSString *)content completionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = @{@"priceRange":[NSString stringWithFormat:@"%ld",(long)range],@"discount":@(discount),@"color":color,@"searchContent":content};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetGoodsWithCondition] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)getGoodsInfo:(NSInteger)goodsID completionHandle:(MBApiArrayBlock)block
{
    NSDictionary *param = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetGoodsInfo] parameters:param handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)collecteGoods:(NSInteger)goodsID completionHandle:(MBApiErrorBlock)block
{
    NSDictionary *parems = @{@"goodId":[NSString stringWithFormat:@"%ld",(long)goodsID]};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeCollecteGoods] parameters:parems handleErrorBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error);
    }];
}

+ (void)collectOrderGoodCompletionHandle:(MBApiArrayBlock)block
{
    NSDictionary *parems = nil;
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeGetCollecteOrderGoods] parameters:parems handleArrayBlock:^(MBApiError *error, NSArray *array, id responseObject) {
        block(error,array);
    }];
}

+ (void)feedbackWithMesage:(NSString *)message completionHandle:(MBApiErrorBlock)block
{
    NSDictionary *parems = @{@"content":message};
    [self postWithTokenURL:[self urlWithPostType:MBApiPostTypeFeedback] parameters:parems handleErrorBlock:^(MBApiError *error, NSArray *array, id responseObject) {
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
