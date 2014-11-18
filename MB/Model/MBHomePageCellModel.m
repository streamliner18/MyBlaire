//
//  MBHomePageCellModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageCellModel.h"

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
    return model;
}

+ (instancetype)sharePopularModel
{
    MBHomePageCellModel *model = [self shareModel];
    model.type = MBHomePageCellModelTypePopular;
    return model;
}

+ (instancetype)shareStarSameModel
{
    MBHomePageCellModel *model = [self shareModel];
    model.type = MBHomePageCellModelTypeStarSame;
    return model;
}

@end
