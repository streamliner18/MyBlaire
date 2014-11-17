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
@property (nonatomic) CGFloat currentPrice;
@property (nonatomic) NSString *smallPicture;
@property (nonatomic) NSString *collectCount;
@property (nonatomic) NSString *isCollect;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;
@end
