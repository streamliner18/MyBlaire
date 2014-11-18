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

@interface MBHomePageCellModel : NSObject

@property (nonatomic) NSString *imageName;
@property (nonatomic) MBHomePageCellModelType type;

+ (NSArray *)shareModels;

+ (instancetype)shareDisCountModel;
+ (instancetype)sharePopularModel;
+ (instancetype)shareStarSameModel;

@end
