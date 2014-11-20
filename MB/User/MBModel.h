//
//  MBModel.h
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBModel : NSObject
@property (nonatomic) NSString *token;

+ (instancetype)shareModel;

- (void)save;

- (void)clear;

@end
