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
#import "MBHomePageCellModel.h"
#import "MBKeyWord.h"
#import "MBSearchResultViewController.h"
#import "MBHomePageSubViewController.h"

typedef void(^MBKeywordsBlock)(NSArray *keys);

@interface MBHomePageViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MBSearchView *searchView;
@property (nonatomic, strong) NSArray *keyWordArray;
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
    [LoginManager showLoginView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [UISearchBar homePageSearchBar];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    self.dataSource = [MBHomePageCellModel shareModels];
    [self.tableView reloadData];
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath
{
    return @"MBHomePageViewCell";
}

- (id)cellModelAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBHomePageCellModel *model = self.dataSource[indexPath.row];
    if (model.subModelArray) {
        MBHomePageSubViewController *viewController = [[MBHomePageSubViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        MBSearchResultViewController *viewController = [[MBSearchResultViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:viewController animated:YES];
    }
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
    [self searchWithKey:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)showSearchView
{
    self.tableView.scrollEnabled = NO;
    self.searchView = [[MBSearchView alloc] initWithFrame:CGRectMake(0, self.searchBar.height, self.tableView.width, self.tableView.height - self.searchBar.height)tags:nil];
    @weakify(self);
    [self refreshKeywords:^(NSArray *keys) {
        @strongify(self);
        [self.searchView resetTags:keys];
    }];
    self.searchView.tagTapAction = ^(NSString *tag,NSInteger index){
        @strongify(self);
        MBKeyWord *keyWord = [self.keyWordArray objectAtIndex:index];
        [self searchWithKey:nil/*keyWord.wordKey*/];
    };
    [self.tableView addSubview:self.searchView];
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

#pragma mark - Search Action

- (void)searchWithKey:(NSString *)key
{
    [self.searchBar resignFirstResponder];
    MBSearchResultViewController *searchResultViewController = [[MBSearchResultViewController alloc] initWithSearchKey:key];
    [self.navigationController pushViewController:searchResultViewController animated:YES];
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"蜜包";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
