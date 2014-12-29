//
//  MBHomePageCellNewModel.h
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProductModel.h"


@interface MBHomePageCellNewModel : NSObject
@end

@interface MBHomePageCellNewModelDiscount : MBHomePageCellNewModel
@property (nonatomic, strong) NSMutableArray *discountProducts;
+ (instancetype)shareWithArray:(NSArray *)array;
@end

@interface MBHomePageCellNewModelPopular : MBHomePageCellNewModel
@property (nonatomic, strong) NSMutableArray *popularProducts;
+ (instancetype)shareWithArray:(NSArray *)array;
@end

@interface MBHomePageCellNewModelStarSame : MBHomePageCellNewModel
@property (nonatomic, strong) MBProductModel *product;
+ (NSArray *)shareWithArray:(NSArray *)array;
@end
