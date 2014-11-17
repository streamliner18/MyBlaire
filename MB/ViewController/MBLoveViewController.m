//
//  MBLoveViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBLoveViewController.h"
#import "MBProductListView.h"

@interface MBLoveViewController ()
@property (nonatomic, strong) MBProductListView *productListView;
@end

@implementation MBLoveViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"喜欢" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_3_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_3_normal"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productListView = [[MBProductListView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.productListView];
    [self.productListView resetDatasource:[Test_Products test_products:30]];
    // Do any additional setup after loading the view.
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"喜欢";
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
