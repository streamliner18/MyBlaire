//
//  MBProductListView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBProductListView.h"
#import <PSCollectionView.h>
#import "MBProductCell.h"
#import "MBProductModel.h"

@interface MBProductListView ()<PSCollectionViewDataSource,PSCollectionViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) PSCollectionView *listView;

@end

@implementation MBProductListView

#pragma mark - properties

- (PSCollectionView *)listView
{
    if (!_listView) {
        _listView = ({
            PSCollectionView *view = [[PSCollectionView alloc] initWithFrame:self.bounds];
            view.numColsPortrait = 2;
            view.collectionViewDataSource = self;
            view.collectionViewDelegate = self;
            view.backgroundColor = [UIColor clearColor];
            view;
        });
    }
    return _listView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.listView];
    }
    return self;
}

- (void)resetDatasource:(NSArray *)array
{
    self.dataSource = array;
    [self.listView reloadData];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return self.dataSource.count;
}
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    MBProductCell *cell = (MBProductCell *)[collectionView dequeueReusableViewForClass:[MBProductCell class]];
    if (cell == nil) {
        cell = [[MBProductCell alloc] initWithFrame:CGRectZero];
    }
    [cell collectionView:collectionView fillCellWithObject:self.dataSource[index] atIndex:index];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index;
{
    return [MBProductCell rowHeightForObject:self.dataSource[index] inColumnWidth:collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
}

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [MBProductCell class];
}




@end
