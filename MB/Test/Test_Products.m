//
//  Test_Products.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "Test_Products.h"
#import "MBProductModel.h"

@implementation Test_Products
+ (NSArray *)test_products:(NSInteger)productCount
{
    NSMutableArray *array = @[].mutableCopy;
    for (int i = 0; i < productCount; i++) {
        MBProductModel *model = [[MBProductModel alloc] init];
        model.smallPicture = @"http://e.hiphotos.baidu.com/news/crop%3D0%2C0%2C583%2C350%3Bw%3D638/sign=0d57a2ba9f82d158afcd03f1bd3a35e8/d01373f082025aaf78515a9ff8edab64034f1a06.jpg";
        model.goodName = @"测试";
        model.currentPrice = @"1000.0";
        model.imageWidth = 120;
        model.imageHeight = 90;
        model.collectCount = 99;
        [array addObject:model];
    }
    return array;
}
@end
