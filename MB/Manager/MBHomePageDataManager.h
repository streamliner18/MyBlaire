//
//  MBHomePageDataManager.h
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBHomePageCellNewModel.h"

typedef void(^MBHomePageDataManagerResult)(MBApiError *error, NSArray *discountArray,NSArray *popularArray, NSArray *starSameArray);

@interface MBHomePageDataManager : NSObject

+ (void)shareData:(MBHomePageDataManagerResult)result;

@end
