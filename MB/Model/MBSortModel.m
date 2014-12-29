//
//  MBSortModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortModel.h"

@implementation MBSortSubModel

+ (instancetype)shareWithTitle:(NSString *)title type:(NSInteger)type category:(MBSortModelType)category
{
    MBSortSubModel *model = [[MBSortSubModel alloc] init];
    model.title = title;
    model.type = type;
    model.categoryType = category;
    return model;
}

+ (instancetype)shareWithColorType:(NSInteger)type
{
    MBSortSubModel *model = [[MBSortSubModel alloc] init];
    model.color = [self subModelColorWithType:type];
    model.type = type;
    model.categoryType = MBSortModelTypeColor;
    return model;
}

+ (UIColor *)subModelColorWithType:(NSInteger)type
{
    return [UIColor redColor];
}

+ (NSArray *)shareWithType:(MBSortModelType)type
{
    NSMutableArray *array = @[].mutableCopy;
    switch (type) {
        case MBSortModelTypePrice:
        {
            [array addObject:[MBSortSubModel shareWithTitle:@"1W以上" type:MBGoodsConditionMoreThan10000 category:MBSortModelTypePrice]];
            [array addObject:[MBSortSubModel shareWithTitle:@"5,000~10,000" type:MBGoodsConditionBetween5000And10000 category:MBSortModelTypePrice]];
            [array addObject:[MBSortSubModel shareWithTitle:@"1,000~5,000" type:MBGoodsConditionBetween1000And5000 category:MBSortModelTypePrice]];
            [array addObject:[MBSortSubModel shareWithTitle:@"1,000一下" type:MBGoodsConditionLessThan1000 category:MBSortModelTypePrice]];
            break;
        }
        case MBSortModelTypeDiscount:
        {
            [array addObject:[MBSortSubModel shareWithTitle:@"9折" type:MBGoodsDiscount9 category:MBSortModelTypeDiscount]];
            [array addObject:[MBSortSubModel shareWithTitle:@"8折" type:MBGoodsDiscount8 category:MBSortModelTypeDiscount]];
            [array addObject:[MBSortSubModel shareWithTitle:@"7折" type:MBGoodsDiscount7 category:MBSortModelTypeDiscount]];
            [array addObject:[MBSortSubModel shareWithTitle:@"更多折扣" type:MBGoodsDiscount0 category:MBSortModelTypeDiscount]];
            break;
        }
            break;
        case MBSortModelTypeColor:
        {
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorBlue]];
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorOrange]];
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorBlue]];
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorWhite]];
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorRed]];
            break;
        }
        default:
            break;
    }
    return array;
}
@end

@implementation MBSortModel
+ (instancetype)shareWithType:(MBSortModelType)type
{
    MBSortModel *model = [[MBSortModel alloc] init];
    model.type = type;
    switch (type) {
        case MBSortModelTypePrice:
            model.title = @"价 格 区 间";
            break;
        case MBSortModelTypeDiscount:
            model.title = @"折 扣";
            break;
        case MBSortModelTypeColor:
            model.title = @"颜 色";
            break;
        default:
            break;
    }
    model.subSortModels = [MBSortSubModel shareWithType:type];
    return model;
}
@end
