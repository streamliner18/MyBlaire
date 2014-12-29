//
//  MBShareViewController.h
//  MB
//
//  Created by Tongtong Xu on 14/12/3.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"

typedef void(^MBShareViewControllerHideBlock)(void);

@class MBProductModel;
@interface MBShareViewController : TTXBaseViewController
- (instancetype)initWithModel:(MBProductModel *)model;
@property (nonatomic, copy)MBShareViewControllerHideBlock hideBlock;
@end
