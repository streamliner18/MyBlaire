//
//  MBSta.m
//  MB
//
//  Created by Tongtong Xu on 14/12/7.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSta.h"

@implementation MBSta
+ (void)registSta
{
    [MobClick startWithAppkey:kUmengAppkey];
}
+ (void)staWithType:(MBStaType)type param:(NSString *)param
{
    NSString *event;
    NSString *label;
    switch (type) {
        case MBStaTypeClickCollecte:
            event = @"收藏按钮";
            label = param;
            break;
        case MBStaTypeClickGoods:
            event = @"产看商品";
            label = param;
            break;
        case MBStaTypeClickKeyWord:
            event = @"点击关键字";
            label = param;
            break;
        case MBStaTypeClickShare:
            event = @"分享";
            label = param;
            break;
        case MBStaTypeClickUnCollecte:
            event = @"取消收藏";
            break;
        case MBStaTypeSearch:
            event = @"搜索";
            break;
        default:
            break;
    }
    [self mobClick:event label:label];
}

+ (void)mobClick:(NSString *)event label:(NSString *)label
{
    [MobClick event:event label:label];
}

@end
