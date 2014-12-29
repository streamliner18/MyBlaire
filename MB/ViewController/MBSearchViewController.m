//
//  MBSearchViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchViewController.h"
#import "MBSearchResultViewController.h"
#import "MBSearchView.h"
#import "MBKeyWord.h"
#import "MBProductListView.h"
#import "MBProductModel.h"
#import "MBGoodsInfoViewController.h"
#import "UISearchBar+Extent.h"
#import "MLBlackTransition.h"

typedef void(^MBKeywordsBlock)(NSArray *keys);

@interface MBSearchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSArray *keyWordArray;
@property (nonatomic, strong) MBSearchView *searchView;
@property (nonatomic, strong) UIView *searchTempView;
@property (nonatomic) BOOL isFirstLoad;

@property (nonatomic) UIImage *image;
@end

@implementation MBSearchViewController

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_2_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_2_normal"]];
    }
    return self;
}

- (UIView *)searchTempView
{
    if (!_searchTempView) {
        _searchTempView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view;
        });
    }
    return _searchTempView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_isFirstLoad) {
        _isFirstLoad = YES;
        [_textField becomeFirstResponder];
    }
    if (self.autoSearchAction) {
        self.autoSearchAction();
        self.autoSearchAction = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kiOS7?64:44)];
    header.backgroundColor = [UIColor whiteColor];
    [self.mbView addSubview:header];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, header.height - 0.5, header.width, 0.5)];
    lineView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:lineView];
    
    
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(4.5, 11.5+(kiOS7?20:0), self.view.width * (534 / 640.0), 27)];
    imageView.image = [[UIImage bt_imageWithBundleName:@"Source" filepath:@"Search" imageName:@"searchbase"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    imageView.userInteractionEnabled = YES;
    [header addSubview:imageView];
    
    UIImageView *si = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5.5, 16, 16)];
    si.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Search" imageName:@"searchIcon"];
    [imageView addSubview:si];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(si.right+10, si.top, imageView.width - si.right - 10, si.height)];
    _textField.placeholder = @"搜索";
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.delegate = self;
    [imageView addSubview:_textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(imageView.right, imageView.top, self.view.width - imageView.right, imageView.height);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#434a54"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(cancleSearch) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    
    
    self.searchView = [[MBSearchView alloc] initWithFrame:CGRectMake(0, header.bottom, self.mbView.width, self.mbView.height - (kiOS7?(64+49):49))tags:nil image:self.image];
    @weakify(self);
    [self refreshKeywords:^(NSArray *keys) {
        @strongify(self);
        [self.searchView resetTags:keys];
    }];
    self.searchView.tagTapAction = ^(NSString *tag,NSInteger index){
        @strongify(self);
        MBKeyWord *keyWord = [self.keyWordArray objectAtIndex:index];
        [MBSta staWithType:MBStaTypeClickKeyWord param:keyWord.wordKey];
        [self searchWithKeyWord:keyWord.wordKey];
    };
    [self.mbView addSubview:self.searchView];
    
    self.searchTempView.frame = CGRectMake(0, (kiOS7?64:0), self.mbView.width, self.mbView.height - (kiOS7?(64+49):49));
    [self.mbView addSubview:self.searchTempView];
    if (!kiOS7) {
        self.searchTempView.height -= (44);
    }
    self.searchTempView.backgroundColor = [UIColor whiteColor];
    self.searchTempView.hidden = YES;
}

- (void)cancleSearch
{
    [_textField resignFirstResponder];
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.searchView.hidden = NO;
    self.searchTempView.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    [self searchWithKeyWord:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return YES;
}

- (void)refreshKeywords:(MBKeywordsBlock)block
{
    if (self.keyWordArray) {
        block([self currentKeywords]);
    }else{
        [MBApi getKeyWordWithCompletionHandle:^(MBApiError *error, NSArray *array) {
            if (error.code == 0) {
                self.keyWordArray = [MBKeyWord shareWithArray:array];
                block ([self currentKeywords]);
            }else{
                [self showMessageHUDWithMessage:@"获取关键词失败"];
            }
        }];
    }
}

- (NSArray *)currentKeywords
{
    NSMutableArray *keys = @[].mutableCopy;
    for (MBKeyWord *object in self.keyWordArray) {
        if (object.wordValue) {
            [keys addObject:object.wordValue];
        }
    }
    return keys;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (searchText.length > 0) {
        [MBSta staWithType:MBStaTypeSearch param:nil];
        [self searchWithKeyWord:searchText];
    }
}

- (void)searchWithKeyWord:(NSString *)searchKey
{
    [_textField resignFirstResponder];
    self.searchTempView.hidden = NO;
    [self.searchTempView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self showProgressHUD];
    MBProductListView *productListView = [[MBProductListView alloc] initWithFrame:self.searchTempView.bounds type:MBProductListViewTypeNormal];
    productListView.selecteGoodsBlock = ^(MBProductModel *model){
        MBGoodsInfoViewController *info = [[MBGoodsInfoViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:info animated:YES];
    };
    @weakify(self,productListView);
    productListView.collecteGoodsBlock = ^(MBProductModel *model){
        [self showProgressHUD];
        [MBApi collecteGoods:model.goodId collecteState:model.isCollect?@"1":@"0" completionHandle:^(MBApiError *error) {
            @strongify(self,productListView);
            [self hideProgressHUD];
            [self showMessageHUDWithMessage:error.message];
            if (error.code == MBApiCodeSuccess) {
                if (model.isCollect) {
                    model.collectCount--;
                }else{
                    model.collectCount++;
                }
                model.isCollect = !model.isCollect;
                [productListView reloadDate];
            }
        }];
    };

    [self.searchTempView addSubview:productListView];
    [self showProgressHUD];
    [MBApi getGoodsWithPriceRange:[MBSorter shared].currentPriceSortModel.type discount:[MBSorter shared].currentDiscountSortModel.type color:[MBSorter shared].currentColor searchContent:searchKey completionHandle:^(MBApiError *error, NSArray *array) {
        [self hideProgressHUD];
        if (error.code == MBApiCodeSuccess) {
            if (array.count) {
                [productListView resetDatasource:[MBProductModel productsWithArray:array]];
            }else{
                [productListView removeFromSuperview];
                UILabel *label = ({
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 19, 200, 18)];
                    label.text = @"没有符合条件的商品";
                    label.font = [UIFont systemFontOfSize:16];
                    label.textColor = [UIColor colorWithHexString:@"#81868d"];
                    label.backgroundColor = [UIColor clearColor];
                    label;
                });
                [self.searchTempView addSubview:label];
            }
        }else{
            [self showMessageHUDWithMessage:error.message];
        }
    }];
}

- (void)dealWithResult:(MBApiError *)error array:(NSArray *)array
{
    
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"";
}

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
