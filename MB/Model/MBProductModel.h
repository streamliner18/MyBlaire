//
//  MBProductModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProductModel : NSObject
@property (nonatomic) NSString *imageURL;
@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;
@property (nonatomic) NSString *name;
@property (nonatomic) CGFloat price;
@property (nonatomic) NSInteger loveCount;
@property (nonatomic) BOOL isLoved;
@end
