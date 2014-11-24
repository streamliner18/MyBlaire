//
//  MBSearchViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchViewController.h"
#import "MBSearchResultViewController.h"

@interface MBSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchWordsListView;
@property (nonatomic, strong) NSArray *userSearchWords;
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

- (UITableView *)searchWordsListView
{
    if (!_searchWordsListView) {
        _searchWordsListView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView;
        });
    }
    return _searchWordsListView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [_searchBar sizeToFit];
    _searchBar.placeholder = @"Search";
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    self.userSearchWords = [[NSUserDefaults standardUserDefaults] arrayForKey:@"USERSEARCHWORDS"] ? [[NSUserDefaults standardUserDefaults] arrayForKey:@"USERSEARCHWORDS"] : @[];
    
    self.searchWordsListView.frame = self.view.bounds;
    [self.view addSubview:self.searchWordsListView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userSearchWords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLLL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLLL"];
    }
    cell.textLabel.text = self.userSearchWords[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self searchWithKeyWord:self.userSearchWords[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSString *searchText = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (searchText.length > 0) {
        [self searchWithKeyWord:searchText];
        NSMutableArray *array = self.userSearchWords.mutableCopy;
        [array addObject:searchText];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"USERSEARCHWORDS"];
        self.userSearchWords = array;
        [self.searchWordsListView reloadData];
    }
}

- (void)searchWithKeyWord:(NSString *)searchKey
{
    MBSearchResultViewController *searchResultViewController = [[MBSearchResultViewController alloc] initWithSearchKey:nil/*searchKey*/];
    [self.navigationController pushViewController:searchResultViewController animated:YES];
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

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
