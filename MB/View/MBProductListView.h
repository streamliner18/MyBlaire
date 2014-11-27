//
//  MBProductListView.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProductModel;

typedef NS_ENUM(NSUInteger, MBProductListViewType) {
    MBProductListViewTypeNormal = 0,
    MBProductListViewTypeStreet = 1,
};

typedef void(^MBProductListViewSelecteGoodsBlock)(MBProductModel *model);

@interface MBProductListView : UIView

- (void)resetDatasource:(NSArray *)array;
- (instancetype)initWithFrame:(CGRect)frame type:(MBProductListViewType)type;
@property (nonatomic, copy) MBProductListViewSelecteGoodsBlock selecteGoodsBlock;
@property (nonatomic, copy) TTXActionBlock collecteGoodsBlock;

@end
