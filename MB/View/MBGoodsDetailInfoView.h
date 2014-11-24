//
//  MBGoodsDetailInfoView.h
//  MB
//
//  Created by Tongtong Xu on 14/11/23.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "FXBlurView.h"

@class MBProductModel;

@interface MBGoodsDetailInfoView : FXBlurView

- (instancetype)initWithFrame:(CGRect)frame model:(MBProductModel *)model;

@end
