//
//  MBSearchResultViewController.m
//  MB
//
//  Created by xt-work on 14/11/20.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchResultViewController.h"
#import "MBProductListView.h"
#import "MBProductModel.h"
#import "MBGoodsInfoViewController.h"
#import "MBHomePageCellModel.h"

@interface MBSearchResultViewController ()
@property (nonatomic) NSString *searchKey;
@property (nonatomic, strong) MBProductListView *productListView;
@property (nonatomic, strong) MBHomePageCellModel *model;
@end

@implementation MBSearchResultViewController

- (instancetype)initWithSearchKey:(NSString *)searchKey
{
    if (self = [super init]) {
        self.searchKey = searchKey;
        self.model = nil;
    }
    return self;
}

- (instancetype)initWithModel:(MBHomePageCellModel *)model
{
    if (self = [super init]) {
        self.searchKey = nil;
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    if (!kiOS7) {
        self.productListView.height -= (44+49);
    }
    if (self.model) {
        self.navigationItem.title = self.model.title;
        [self showProgressHUD];
        if (self.model.type == MBHomePageCellModelTypePopular) {
            self.productListView = [[MBProductListView alloc] initWithFrame:self.view.bounds type:MBProductListViewTypeNormal];
            [MBApi getHotGoodsWithCompletionHandle:^(MBApiError *error, id array) {
                [self dealWithResult:error array:array];
            }];
        }else if (self.model.type == MBHomePageCellModelTypeStarSame) {
            self.productListView = [[MBProductListView alloc] initWithFrame:self.view.bounds type:MBProductListViewTypeStreet];
            [MBApi getStreetShootingGoodsWithCompletionHandle:^(MBApiError *error, id array) {
                [self dealWithResult:error array:array];
            }];
        }
    }else {
        self.productListView = [[MBProductListView alloc] initWithFrame:self.view.bounds type:MBProductListViewTypeNormal];
        self.navigationItem.title = @"搜索结果";
        [self showProgressHUD];
        [MBApi getGoodsWithPriceRange:[MBSorter shared].currentPriceSortModel.type discount:[MBSorter shared].currentDiscountSortModel.type color:[[MBSorter shared] currentColor] searchContent:self.searchKey completionHandle:^(MBApiError *error, NSArray *array) {
            [self dealWithResult:error array:array];
        }];
    }
    [self.mbView addSubview:self.productListView];
    
    @weakify(self);
    self.productListView.selecteGoodsBlock = ^(MBProductModel *model){
        @strongify(self);
        MBGoodsInfoViewController *goods = [[MBGoodsInfoViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:goods animated:YES];
    };
    self.productListView.collecteGoodsBlock = ^(MBProductModel *model){
        @strongify(self);
        [self showProgressHUD];
        [MBApi collecteGoods:model.goodId collecteState:model.isCollect?@"1":@"0" completionHandle:^(MBApiError *error) {
            [self hideProgressHUD];
            [self showMessageHUDWithMessage:error.message];
        }];
    };
}

- (void)dealWithResult:(MBApiError *)error array:(NSArray *)array
{
    [self hideProgressHUD];
    if (error.code == MBApiCodeSuccess) {
        [self reloadProductListView:array];
    }else{
        [self showMessageHUDWithMessage:error.message];
    }
}

- (void)reloadProductListView:(NSArray *)array
{
    [self.productListView resetDatasource:[MBProductModel productsWithArray:array]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

@end
