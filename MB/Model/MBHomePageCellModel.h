//
//  MBHomePageCellModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBHomePageCellModelType) {
    MBHomePageCellModelTypeDiscount,
    MBHomePageCellModelTypePopular,
    MBHomePageCellModelTypeStarSame,
};

typedef NS_ENUM(NSUInteger, MBHomePageCellDiscountSubModelType) {
    MBHomePageCellDiscountSubModelType50Off,
    MBHomePageCellDiscountSubModelType40Off,
    MBHomePageCellDiscountSubModelType30Off,
};

@interface MBHomePageCellSubModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) MBHomePageCellDiscountSubModelType subModelType;
@end

@interface MBHomePageCellModel : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *imageName;
@property (nonatomic) MBHomePageCellModelType type;
@property (nonatomic, strong) NSArray *subModelArray;

+ (NSArray *)shareModels;

+ (instancetype)shareDisCountModel;
+ (instancetype)sharePopularModel;
+ (instancetype)shareStarSameModel;

@end
