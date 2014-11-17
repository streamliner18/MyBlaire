//
//  MBHomePageViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageViewController.h"
#import "MBGuideViewController.h"
#import "MBSearchView.h"

@interface MBHomePageViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MBSearchView *searchView;
@end

@implementation MBHomePageViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_1_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_1_normal"]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [GuideViewManager showGuildWithAppVersion:TTX_ShowGuide_AppVersion()];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [UISearchBar homePageSearchBar];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath
{
    return @"MBHomePageViewCell";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    UIViewController *c = [[UIViewController alloc] init];
    c.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:c animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - searchBar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    [self showSearchView];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [self hideSearchView];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)showSearchView
{
    self.tableView.scrollEnabled = NO;
    self.searchView = [[MBSearchView alloc] initWithFrame:CGRectMake(0, self.searchBar.height, self.tableView.width, self.tableView.height - self.searchBar.height)tags:@[@"关键词1",@"关键词2",@"关键词3"]];
    self.searchView.tagTapAction = ^(NSString *tag,NSInteger index){
        DLog(@"%@",tag);
    };
    [self.tableView addSubview:self.searchView];
}

- (void)hideSearchView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 0;
    }completion:^(BOOL finished) {
        self.tableView.scrollEnabled = YES;
        [self.searchView removeFromSuperview];
        self.searchView = nil;
    }];
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"蜜包";
}

+ (NSString *)navigationItemDisappearTitle
{
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
