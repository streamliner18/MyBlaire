//
//  TTXBaseTableViewController.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"
#import "TTXBaseTableViewCell.h"

@interface TTXBaseTableViewController : TTXBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath;

- (id)cellModelAtIndexPath:(NSIndexPath *)indexPath;

@end
