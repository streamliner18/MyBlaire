//
//  MBHomePageCellModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageCellModel.h"

@implementation MBHomePageCellSubModel

+ (instancetype)shareSubModel:(MBHomePageCellDiscountSubModelType)type
{
    MBHomePageCellSubModel *model = [[MBHomePageCellSubModel alloc] init];
    model.subModelType = type;
    model.title = [self titleWithType:type];
    return model;
}

+ (NSString *)titleWithType:(MBHomePageCellDiscountSubModelType)type
{
    switch (type) {
        case MBHomePageCellDiscountSubModelType50Off:
            return @"50%折扣";
            break;
        case MBHomePageCellDiscountSubModelType40Off:
            return @"40%折扣";
            break;
        case MBHomePageCellDiscountSubModelType30Off:
            return @"30%折扣";
            break;
        default:
            break;
    }
}

@end

@implementation MBHomePageCellModel

+ (NSArray *)shareModels
{
    return @[[self shareDisCountModel],[self sharePopularModel],[self shareStarSameModel]];
}

+ (instancetype)shareModel{
    MBHomePageCellModel *model = [[MBHomePageCellModel alloc] init];
    model.imageName = @"111";
    return model;
}

+ (instancetype)shareDisCountModel
{
    MBHomePageCellModel *model = [self shareModel];
    model.type = MBHomePageCellModelTypeDiscount;
    model.title = @"最优折扣";
    model.subModelArray = @[
                            [MBHomePageCellSubModel shareSubModel:MBHomePageCellDiscountSubModelType50Off],
                            [MBHomePageCellSubModel shareSubModel:MBHomePageCellDiscountSubModelType40Off],
                            [MBHomePageCellSubModel shareSubModel:MBHomePageCellDiscountSubModelType30Off],
                            ];
    return model;
}

+ (instancetype)sharePopularModel
{
    MBHomePageCellModel *model = [self shareModel];
    model.title = @"最具人气";
    model.type = MBHomePageCellModelTypePopular;
    return model;
}

+ (instancetype)shareStarSameModel
{
    MBHomePageCellModel *model = [self shareModel];
    model.title = @"明星同款";
    model.type = MBHomePageCellModelTypeStarSame;
    return model;
}

@end
