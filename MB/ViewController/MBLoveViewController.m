//
//  MBLoveViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBLoveViewController.h"
#import "MBProductListView.h"
#import "MBProductModel.h"
#import "MBGoodsInfoViewController.h"

@interface MBLoveViewController ()
@property (nonatomic, strong) MBProductListView *productListView;
@end

@implementation MBLoveViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"心愿单" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_3_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_3_normal"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"Hello, %@",MB_Model.userName];
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (!kiOS7 ? (44 + 49) : 0));
    self.productListView = [[MBProductListView alloc] initWithFrame:rect type:MBProductListViewTypeStreet];
    [self.mbView addSubview:self.productListView];
    
    @weakify(self);
    self.productListView.selecteGoodsBlock = ^(MBProductModel *model){
        @strongify(self);
        MBGoodsInfoViewController *info = [[MBGoodsInfoViewController alloc] initWithModel:model];
        info.showCollecteCount = NO;
        [self.navigationController pushViewController:info animated:YES];
    };
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showProgressHUD];
    [MBApi collectOrderGoodCompletionHandle:^(MBApiError *error, id array) {
        [self hideProgressHUD];
        [self.productListView resetDatasource:[MBProductModel productsWithArray:array]];
    }];
}

#pragma mark - UINavigationProtocol

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
