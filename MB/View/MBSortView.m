//
//  MBSortView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/24.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortView.h"
#import "MBSortModel.h"
#import <PSCollectionView.h>
#import "MBSorter.h"

@interface SecondCollectionViewCell : PSCollectionViewCell
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *signView;
@end

@implementation SecondCollectionViewCell

- (UILabel *)title
{
    if (!_title) {
        _title = [UILabel normalLabel];
    }
    return _title;
}

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _colorView;
}

- (UIImageView *)signView
{
    if (!_signView) {
        _signView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _signView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.title];
        [self addSubview:self.colorView];
        [self addSubview:self.signView];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.signView.image = nil;
    self.title.text = nil;
    self.title.frame =
    self.signView.frame =
    self.colorView.frame = CGRectZero;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    MBSortSubModel *model = self.object;
    if (model) {
        if (model.color) {
            if (model == [MBSorter shared].currentColorSortModel) {
                self.signView.frame = CGRectMake(self.width - 30, 0, 30, 30);
                self.signView.backgroundColor = [UIColor blackColor];
            }
            self.colorView.backgroundColor = model.color;
            self.colorView.frame = CGRectMake(0, 0, self.height, self.height);
        }else if (model.title) {
            if (model == [MBSorter shared].currentDiscountSortModel || model == [MBSorter shared].currentPriceSortModel) {
                self.signView.frame = CGRectMake(self.width - 50, 0, 50, self.height);
                self.signView.backgroundColor = [UIColor blackColor];
            }
            self.title.frame = CGRectMake(0, 0, self.width, self.height);
            self.title.text = model.title;
        }
    }
}

@end


@interface MBSortView ()<UITableViewDataSource,UITableViewDelegate,PSCollectionViewDataSource,PSCollectionViewDelegate>
@property (nonatomic, strong) UITableView *firstListView;
@property (nonatomic, strong) PSCollectionView *secondListView;
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
            tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 10)];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView;
        });
    }
    return _firstListView;
}

- (PSCollectionView *)secondListView
{
    if (!_secondListView) {
        _secondListView = ({
            PSCollectionView *view = [[PSCollectionView alloc] initWithFrame:CGRectZero];
            view.collectionViewDelegate = self;
            view.collectionViewDataSource = self;
            view.numColsPortrait = 1;
            view;
        });
    }
    return _secondListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [[MBSorter shared] buildSorters];
        self.dataSource = [MBSorter shared].defaultSorters;
        self.firstListView.frame = CGRectMake(0, 0, 100, self.height);
        self.secondListView.frame = CGRectMake(100, 0, self.width - 100, self.height);
        [self addSubview:self.firstListView];
        [self addSubview:self.secondListView];
    }
    return self;
}

#pragma mark - tableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBSortModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
    if (model.type == MBSortModelTypeColor) {
        self.secondListView.numColsPortrait = 4;
    }else{
        self.secondListView.numColsPortrait = 1;
    }
    [self.secondListView reloadData];
}

#pragma mark - collectionView Method

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
    return model.subSortModels.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    SecondCollectionViewCell *cell = (SecondCollectionViewCell *)[collectionView dequeueReusableViewForClass:[SecondCollectionViewCell class]];
    if (!cell) {
        cell = [[SecondCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
    MBSortSubModel *subModel = model.subSortModels[index];
    [cell collectionView:collectionView fillCellWithObject:subModel atIndex:index];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 40;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    MBSortModel *model = self.dataSource[[self.firstListView indexPathForSelectedRow].row];
    switch (model.type) {
        case MBSortModelTypePrice:
            [MBSorter shared].currentPriceSortModel = model.subSortModels[index];
            break;
        case MBSortModelTypeDiscount:
            [MBSorter shared].currentDiscountSortModel = model.subSortModels[index];
            break;
        case MBSortModelTypeColor:
            [MBSorter shared].currentColorSortModel = model.subSortModels[index];
            break;
        default:
            break;
    }
    [collectionView reloadData];
}

@end
