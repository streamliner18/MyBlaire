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

@interface MBSearchResultViewController ()
@property (nonatomic) NSString *searchKey;
@property (nonatomic, strong) MBProductListView *productListView;
@end

@implementation MBSearchResultViewController

- (instancetype)initWithSearchKey:(NSString *)searchKey
{
    if (self = [super init]) {
        self.searchKey = searchKey;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productListView = [[MBProductListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.productListView];
    
    [MBApi getGoodsWithPriceRange:MBGoodsConditionNoRange discount:MBGoodsDiscountNoneLimit color:nil searchContent:self.searchKey completionHandle:^(MBApiError *error, NSArray *array) {
        [self reloadProductListView:array];
    }];
    
    // Do any additional setup after loading the view.
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
    return YES;
}

+ (NSString *)navigationItemTitle
{
    return @"搜索结果";
}

@end
