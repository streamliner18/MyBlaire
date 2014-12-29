//
//  MBCategoryView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/27.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBCategoryView.h"
#import <PSCollectionView.h>
#import "MBCategoryCell.h"
#import "MBCategoryModel.h"

@interface MBCategoryView ()<PSCollectionViewDataSource,PSCollectionViewDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) PSCollectionView *listView;
@end

@implementation MBCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:215/255.0 green:217/255.0 blue:219/255.0 alpha:1.0];
        self.dataSource = [MBCategoryModel defaultCategoryModelArray];
        self.listView = ({
            PSCollectionView *collectionView = [[PSCollectionView alloc] initWithFrame:self.bounds];
            collectionView.numColsPortrait = 2;
            collectionView.collectionViewDataSource = self;
            collectionView.collectionViewDelegate = self;
            collectionView.margin = 0;
            collectionView.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
            collectionView;
        });
        [self addSubview:self.listView];
    }
    return self;
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return self.dataSource.count;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    MBCategoryCell *cell = (MBCategoryCell *)[collectionView dequeueReusableViewForClass:[MBCategoryCell class]];
    if (!cell) {
        cell = [[MBCategoryCell alloc] initWithFrame:CGRectZero];
    }
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
    [cell collectionView:collectionView fillCellWithObject:self.dataSource[index] atIndex:index];
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 336 / 328 * collectionView.colWidth;
}


@end
