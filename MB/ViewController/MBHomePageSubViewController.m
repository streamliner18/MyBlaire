//
//  MBHomePageSubViewController.m
//  MB
//
//  Created by xt-work on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageSubViewController.h"
#import "MBHomePageCellModel.h"

@interface MBHomePageSubViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) MBHomePageCellModel *model;
@end

@implementation MBHomePageSubViewController

- (instancetype)initWithModel:(MBHomePageCellModel *)model
{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self.model.subModelArray;
    [self.tableView reloadData];
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath
{
    return @"MBHomePageSubTableViewCell";
}

- (id)cellModelAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBHomePageCellSubModel *model = self.dataSource[indexPath.row];
    DLog(@"%d",model.title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)navigationItemTitle
{
    return @"最优折扣";
}

@end
