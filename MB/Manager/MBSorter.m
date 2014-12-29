//
//  MBSorter.m
//  MB
//
//  Created by xt-work on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSorter.h"

@implementation MBSorter
SINGLETON_IMPLEMENTATION(MBSorter)
- (void)buildSorters
{
    MBSortModel *price = [MBSortModel shareWithType:MBSortModelTypePrice];
    MBSortModel *discount = [MBSortModel shareWithType:MBSortModelTypeDiscount];
    MBSortModel *color = [MBSortModel shareWithType:MBSortModelTypeColor];
    self.defaultSorters = @[price,discount,color];
    [MBSorter shared].currentPriceSortModel = price.subSortModels[2];
    [MBSorter shared].currentDiscountSortModel = discount.subSortModels[0];
    [MBSorter shared].currentColorSortModel = color.subSortModels[0];
    [self reset];
}
- (void)reset
{
    self.currentPriceSortModel.type = MBGoodsConditionBetween1000And5000;
    self.currentDiscountSortModel.type = MBGoodsDiscount9;
    self.currentColorSortModel.type = MBGoodsColorNoneLimit;
}

- (NSString *)currentColor
{
    NSString *color = @"";
    switch (self.currentColorSortModel.type) {
        case 0:
            color = @"red";
            break;
        case 1:
            color = @"pink";
            break;
        case 2:
            color = @"orange";
            break;
        case 3:
            color = @"yellow";
            break;
        case 4:
            color = @"purple";
            break;
        case 5:
            color = @"blue";
            break;
        case 6:
            color = @"green";
            break;
        case 7:
            color = @"darkgrey";
            break;
        case 8:
            color = @"white";
            break;
        case 9:
            color = @"black";
            break;
        case 10:
            color = @"lightgrey";
            break;
        case 11:
            color = @"khaki";
            break;
        default:
            break;
    }
    return color;
}
@end
