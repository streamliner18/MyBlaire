//
//  MBSearchViewController.h
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"

@interface MBSearchViewController : TTXBaseViewController
- (void)searchWithKeyWord:(NSString *)searchKey;
@property (nonatomic, copy) TTXActionBlock autoSearchAction;
- (instancetype)initWithImage:(UIImage *)image;
@end
