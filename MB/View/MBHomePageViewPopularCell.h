//
//  MBHomePageViewPopularCell.h
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseTableViewCell.h"

@class MBProductModel;
typedef void(^MBHomePageViewDiscountCellTapBlock)(MBProductModel *model);
@interface MBHomePageViewPopularCell : TTXBaseTableViewCell
@property (nonatomic, copy) MBHomePageViewDiscountCellTapBlock tapBlock;
@end
