//
//  MBHomePageSortResultViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/25.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageSortResultViewController.h"
#import "MBProductListView.h"
#import "MBGoodsInfoViewController.h"
#import "MBProductModel.h"
#import "MBSortViewController.h"
#import <MMDrawerController.h>

@interface MBHomePageSortResultViewController ()
@property (nonatomic, strong) MBProductListView *productListView;
@end

@implementation MBHomePageSortResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    self.navigationItem.titleView = [self topImageView];
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - (!kiOS7 ? (44) : 0));
    self.productListView = [[MBProductListView alloc] initWithFrame:rect type:MBProductListViewTypeNormal];
    [self.mbView addSubview:self.productListView];
    @weakify(self);
    self.productListView.selecteGoodsBlock = ^(MBProductModel *model){
        @strongify(self);
        MBGoodsInfoViewController *info = [[MBGoodsInfoViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:info animated:YES];
    };
    self.productListView.collecteGoodsBlock = ^(MBProductModel *model){
        @strongify(self);
        [self showProgressHUD];
        [MBApi collecteGoods:model.goodId collecteState:model.isCollect?@"1":@"0" completionHandle:^(MBApiError *error) {
            @strongify(self);
            [self hideProgressHUD];
            [self showMessageHUDWithMessage:error.message];
            if (error.code == MBApiCodeSuccess) {
                if (model.isCollect) {
                    model.collectCount--;
                }else{
                    model.collectCount++;
                }
                model.isCollect = !model.isCollect;
                [self.productListView reloadDate];
            }
        }];
    };
    
    MMDrawerController *menu = (MMDrawerController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    MBSortViewController *sortViewController = (MBSortViewController *)menu.leftDrawerViewController;
    BOOL isAllClose = [sortViewController isAllClose];
    
    [MBApi getGoodsWithPriceRange:isAllClose ? MBGoodsConditionNoRange : [MBSorter shared].currentPriceSortModel.type discount:isAllClose ? MBGoodsDiscountNoneLimit : [MBSorter shared].currentDiscountSortModel.type color:isAllClose ? nil : [MBSorter shared].currentColor searchContent:@"" completionHandle:^(MBApiError *error, NSArray *array) {
        [self hideProgressHUD];
        if (error.code == MBApiCodeSuccess) {
            if (array.count) {
                [self.productListView resetDatasource:[MBProductModel productsWithArray:array]];
            }else{
                [self.productListView removeFromSuperview];
                UILabel *label = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 19, 200, 17)];
                    label.text = @"没有符合条件的商品";
                    label.font = [UIFont systemFontOfSize:16];
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor colorWithHexString:@"#81868d"];
                    label;
                });
                [self.mbView addSubview:label];
            }
        }else{
            [self showMessageHUDWithMessage:error.message];
        }
    }];
}

- (UIImageView *)topImageView
{
    UIImageView *topLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 61, 29)];
    topLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Home" imageName:@"TopLogo"];
    return topLogo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
