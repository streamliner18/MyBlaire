//
//  MBSearchResultViewController.h
//  MB
//
//  Created by xt-work on 14/11/20.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"

@class MBHomePageCellModel;

@interface MBSearchResultViewController : TTXBaseViewController

- (instancetype)initWithSearchKey:(NSString *)searchKey;

- (instancetype)initWithModel:(MBHomePageCellModel *)model;

@end
