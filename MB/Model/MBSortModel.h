//
//  MBSortModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBSortModelType) {
    MBSortModelTypePrice,
    MBSortModelTypeDiscount,
    MBSortModelTypeColor,
};

@interface MBSortSubModel : NSObject
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSString *title;
@property (nonatomic) NSInteger type;
+ (NSArray *)shareWithType:(MBSortModelType)type;
@end

@interface MBSortModel : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) MBSortModelType type;
@property (nonatomic, strong) NSArray *subSortModels;

+ (instancetype)shareWithType:(MBSortModelType)type;

@end
