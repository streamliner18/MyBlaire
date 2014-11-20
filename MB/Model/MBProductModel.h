//
//  MBProductModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProductModel : NSObject
@property (nonatomic) NSString *goodId;
@property (nonatomic) NSString *goodName;
@property (nonatomic) long currentPrice;
@property (nonatomic) NSString *smallPicture;
@property (nonatomic) int collectCount;
@property (nonatomic) BOOL isCollect;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;


@property (nonatomic) NSString *detailed;
@property (nonatomic) NSString *materialQuality;
@property (nonatomic) NSString *color;
@property (nonatomic) NSString *goodDesc;
@property (nonatomic) NSString *production;
@property (nonatomic) NSString *bigPctureUrl;
@property (nonatomic) NSString *bigPctureUrl2;
@property (nonatomic) NSString *bigPctureUrl3;

+ (instancetype)shareProduct:(NSDictionary *)dic;

+ (NSArray *)productsWithArray:(NSArray *)array;

@end
