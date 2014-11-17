//
//  MBSearchViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchViewController.h"

@interface MBSearchViewController ()<UISearchBarDelegate>

@end

@implementation MBSearchViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_2_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_2_normal"]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ddddd)]];
    // Do any additional setup after loading the view.
}

- (void)ddddd
{
    UIViewController *c = [[UIViewController alloc] init];
    c.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:c animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
