//
//  MBSta.h
//  MB
//
//  Created by Tongtong Xu on 14/12/7.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMengAnalytics/MobClick.h>

typedef NS_ENUM(NSUInteger, MBStaType) {
    MBStaTypeClickGoods,
    MBStaTypeClickUnCollecte,
    MBStaTypeClickCollecte,
    MBStaTypeClickKeyWord,
    MBStaTypeSearch,
    MBStaTypeClickShare,
};

@interface MBSta : NSObject
+ (void)registSta;
+ (void)staWithType:(MBStaType)type param:(NSString *)param;
@end
