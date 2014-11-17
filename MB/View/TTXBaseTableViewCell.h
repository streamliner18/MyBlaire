//
//  TTXBaseTableViewCell.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTXBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;

//重写这个方法，在cell添加view
- (void)buildSubviews;

+ (CGFloat)cellHeightWithModel:(id)model;

@end
