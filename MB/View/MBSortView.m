//
//  MBSortView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortView.h"
#import "MBSortModel.h"

@interface MBSortView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *firstListView;
@property (nonatomic, strong) UITableView *secondListView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MBSortView

- (UITableView *)firstListView
{
    if (!_firstListView) {
        _firstListView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView;
        });
    }
    return _firstListView;
}

- (UITableView *)secondListView
{
    if (!_secondListView) {
        _secondListView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView;
        });
    }
    return _secondListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = @[[MBSortModel shareWithType:MBSortModelTypePrice],[MBSortModel shareWithType:MBSortModelTypeDiscount],[MBSortModel shareWithType:MBSortModelTypeColor]];
        self.firstListView.frame = CGRectMake(0, 0, 100, self.height);
        self.secondListView.frame = CGRectMake(100, 0, self.width - 100, self.height);
        [self addSubview:self.firstListView];
        [self addSubview:self.secondListView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _secondListView) {
        MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
        return model.subSortModels.count;
    }else{
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstListView) {
        MBSortModel *model = self.dataSource[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = model.title;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondCell"];
        }
        MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
        MBSortSubModel *subModel = model.subSortModels[indexPath.row];
        if (model.type != MBSortModelTypeColor) {
            cell.textLabel.text = subModel.title;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _firstListView) {
        [self.secondListView reloadData];
    }
}

@end
