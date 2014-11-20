//
//  MBKeyWord.m
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBKeyWord.h"

@implementation MBKeyWord

+ (instancetype)shareKeyword:(NSDictionary *)dic
{
    MBKeyWord *model = [[MBKeyWord alloc] init];
    model.wordKey = [dic stringForKey:@"wordKey"];
    model.wordValue = [dic stringForKey:@"wordValue"];
    return model;
}

+ (NSArray *)shareWithArray:(NSArray *)array
{
    NSMutableArray *mulArray = @[].mutableCopy;
    for (NSDictionary *dic in array) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            MBKeyWord *model = [self shareKeyword:dic];
            if (model) {
                [mulArray addObject:model];
            }
        }
    }
    return [NSArray arrayWithArray:mulArray];
}

@end
