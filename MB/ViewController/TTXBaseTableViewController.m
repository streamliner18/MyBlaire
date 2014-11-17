//
//  TTXBaseTableViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseTableViewController.h"

@interface TTXBaseTableViewController ()

@end

@implementation TTXBaseTableViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView;
        });
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
      // Do any additional setup after loading the view.
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id)cellModelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIden = [self cellIdentifyAtIndexPath:indexPath];
    if (cellIden != nil) {
        Class class = NSClassFromString(cellIden);
        id cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        if ([cell isKindOfClass:[TTXBaseTableViewCell class]]) {
            ((TTXBaseTableViewCell *)cell).model = [self cellModelAtIndexPath:indexPath];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
