//
//  MBSorter.h
//  MB
//
//  Created by xt-work on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBSortModel.h"

@interface MBSorter : NSObject
SINGLETON_INTERFACE(MBSorter)
@property (nonatomic, strong) NSArray *defaultSorters;
@property (nonatomic, strong) MBSortSubModel *currentPriceSortModel;
@property (nonatomic, strong) MBSortSubModel *currentDiscountSortModel;
@property (nonatomic, strong) MBSortSubModel *currentColorSortModel;
- (void)buildSorters;
- (void)reset;
- (NSString *)currentColor;
@end
