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
    [MBSorter shared].currentPriceSortModel = price.subSortModels[0];
    [MBSorter shared].currentDiscountSortModel = discount.subSortModels[0];
    [MBSorter shared].currentColorSortModel = color.subSortModels[0];
}
@end
