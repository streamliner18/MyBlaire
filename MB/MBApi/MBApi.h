//
//  MBApi.h
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBLoginType) {
    MBLoginTypeNormal,
    MBLoginTypeQQ,
    MBLoginTypeSina,
};

typedef NS_ENUM(NSUInteger, MBGoodsPriceRange) {
    MBGoodsConditionMoreThan10000 = 0,
    MBGoodsConditionBetween5000And10000 = 1,
    MBGoodsConditionBetween1000And5000 = 2,
    MBGoodsConditionLessThan1000 = 3,
};

typedef NS_ENUM(NSUInteger, MBGoodsDiscount) {
    MBGoodsDiscount9 = 9,
    MBGoodsDiscount8 = 8,
    MBGoodsDiscount7 = 7,
    MBGoodsDiscount0 = 0,
};

typedef void(^MBApiErrorBlock)(MBApiError *error);
typedef void(^MBApiArrayBlock)(MBApiError *error, NSArray *array);

@interface MBApi : NSObject

/**
 *  注册
 *
 *  @param userName 用户名
 *  @param password 密码
 *  @param mail     邮箱
 *  @param block    注册回调方法
 */

+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password handle:(MBApiErrorBlock)block;

/**
 *  登陆
 *
 *  @param type     登录类型
 *  @param userName 用户名,正常登录需要
 *  @param password 密码,正常登录需要
 *  @param token    token,第三方登录需要
 *  @param block    登录回调方法
 */
+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiErrorBlock)block;

/**
 *  搜索词
 */

+ (void)getKeyWordWithCompletionHandle:(MBApiArrayBlock)block;

/**
 *  最具人气
 */

+ (void)getHotGoodsWithCompletionHandle:(MBApiArrayBlock)block;

/**
 *  明星同款
 */

+ (void)getStreetShootingGoodsWithCompletionHandle:(MBApiArrayBlock)block;

/**
 *  条件搜索
 */

+ (void)getGoodsWithPriceRange:(MBGoodsPriceRange)range discount:(MBGoodsDiscount)discount color:(NSString *)color searchContent:(NSString *)content completionHandle:(MBApiArrayBlock)block;

/**
 *  商品详情
 */
+ (void)getGoodsInfo:(NSInteger)goodsID completionHandle:(MBApiArrayBlock)block;
/**
 *  收藏
 */
+ (void)collecteGoods:(NSInteger)goodsID completionHandle:(MBApiErrorBlock)block;
/**
 *  心愿单
 */
+ (void)collectOrderGoodCompletionHandle:(MBApiArrayBlock)block;

+ (void)feedbackWithMesage:(NSString *)message completionHandle:(MBApiErrorBlock)block;


@end
