//
//  MBSortModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortModel.h"

@implementation MBSortSubModel

+ (instancetype)shareWithTitle:(NSString *)title type:(NSInteger)type
{
    MBSortSubModel *model = [[MBSortSubModel alloc] init];
    model.title = title;
    model.type = type;
    return model;
}

+ (instancetype)shareWithColorType:(NSInteger)type
{
    MBSortSubModel *model = [[MBSortSubModel alloc] init];
    model.color = [self subModelColorWithType:type];
    model.type = type;
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
            [array addObject:[MBSortSubModel shareWithTitle:@"1W以上" type:MBGoodsConditionMoreThan10000]];
            [array addObject:[MBSortSubModel shareWithTitle:@"5,000~10,000" type:MBGoodsConditionBetween5000And10000]];
            [array addObject:[MBSortSubModel shareWithTitle:@"1,000~5,000" type:MBGoodsConditionBetween1000And5000]];
            [array addObject:[MBSortSubModel shareWithTitle:@"1,000一下" type:MBGoodsConditionLessThan1000]];
            break;
        }
        case MBSortModelTypeDiscount:
        {
            [array addObject:[MBSortSubModel shareWithTitle:@"9折" type:MBGoodsDiscount9]];
            [array addObject:[MBSortSubModel shareWithTitle:@"8折" type:MBGoodsDiscount8]];
            [array addObject:[MBSortSubModel shareWithTitle:@"7折" type:MBGoodsDiscount7]];
            [array addObject:[MBSortSubModel shareWithTitle:@"更多折扣" type:MBGoodsDiscount0]];
            break;
        }
            break;
        case MBSortModelTypeColor:
        {
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorBlack]];
            [array addObject:[MBSortSubModel shareWithColorType:MBGoodsColorOrigion]];
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
            model.title = @"价格";
            break;
        case MBSortModelTypeDiscount:
            model.title = @"折扣";
            break;
        case MBSortModelTypeColor:
            model.title = @"颜色";
            break;
        default:
            break;
    }
    model.subSortModels = [MBSortSubModel shareWithType:type];
    return model;
}
@end
