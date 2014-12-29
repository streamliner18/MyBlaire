//
//  MBCategoryModel.m
//  MB
//
//  Created by Tongtong Xu on 14/11/27.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBCategoryModel.h"

@implementation MBCategoryModel
+ (NSArray *)defaultCategoryModelArray
{
    NSArray *title = @[@"长柄手提包",@"短柄手提包",@"挎包",@"钱包",@"手袋",@"垃圾袋"];
    NSMutableArray *array = @[].mutableCopy;
    for (int i = 0; i < title.count; i++) {
        MBCategoryModel *model = [[MBCategoryModel alloc] init];
        model.name = title[i];
        model.imageName = [NSString stringWithFormat:@"bag_asset-%d",i+1];
        [array addObject:model];
    }
    return array;
}
@end
