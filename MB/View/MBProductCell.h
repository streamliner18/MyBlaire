//
//  MBProductCell.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <PSCollectionViewCell.h>

typedef NS_ENUM(NSUInteger, MBProductCellType) {
    MBProductCellTypeNormal = 0,
    MBProductCellTypeStreet = 1,
};

@interface MBProductCell : PSCollectionViewCell
@property (nonatomic) MBProductCellType type;
@property (nonatomic, copy) TTXActionBlock collecteGoodsBlock;
@end
