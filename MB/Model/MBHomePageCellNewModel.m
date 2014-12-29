//
//  MBHomePageCellNewModel.m
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageCellNewModel.h"

@implementation MBHomePageCellNewModel

@end

@implementation MBHomePageCellNewModelDiscount

+ (instancetype)shareWithArray:(NSArray *)array
{
    MBHomePageCellNewModelDiscount *discount = [[MBHomePageCellNewModelDiscount alloc] init];
    discount.discountProducts = @[].mutableCopy;
    if (![array isKindOfClass:[NSNull class]] && array.count) {
        for (NSDictionary *dic in array) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                MBProductModel *model = [MBProductModel shareProduct:dic];
                [discount.discountProducts addObject:model];
            }
        }
    }
    return discount;
}

@end

@implementation MBHomePageCellNewModelPopular

+ (instancetype)shareWithArray:(NSArray *)array
{
    MBHomePageCellNewModelPopular *popular = [[MBHomePageCellNewModelPopular alloc] init];
    popular.popularProducts = @[].mutableCopy;
    if (![array isKindOfClass:[NSNull class]] && array.count) {
        for (NSDictionary *dic in array) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                MBProductModel *model = [MBProductModel shareProduct:dic];
                [popular.popularProducts addObject:model];
            }
        }
    }
    return popular;
}
@end

@implementation MBHomePageCellNewModelStarSame
+ (NSArray *)shareWithArray:(NSArray *)array
{
    NSMutableArray *products = @[].mutableCopy;
    if (![array isKindOfClass:[NSNull class]] && array.count) {
        for (NSDictionary *dic in array) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                MBHomePageCellNewModelStarSame *starSame = [[MBHomePageCellNewModelStarSame alloc] init];
                MBProductModel *model = [MBProductModel shareProduct:dic];
                starSame.product = model;
                [products addObject:starSame];
            }
        }
    }
    return products;
}
@end
