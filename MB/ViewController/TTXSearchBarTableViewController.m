//
//  TTXSearchBarTableViewController.m
//  TableViewSearchBar
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXSearchBarTableViewController.h"

static NSString * const kTTXSearchBarTableViewControllerDefaultTableViewCellIdentifier = @"kTTXSearchBarTableViewControllerDefaultTableViewCellIdentifier";

@interface TTXSearchBarTableViewController () {
    
}

@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong, readwrite) UISearchBar *searchBar;

@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;

@end

@implementation TTXSearchBarTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"Search";
    self.searchBar.delegate = self;
    
    [self.searchBar sizeToFit];
    
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//    self.strongSearchDisplayController.de legate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (animated) {
        [self.tableView flashScrollIndicators];
    }
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated
{
    NSAssert(YES, @"This method should be handled by a subclass!");
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    DLog(@"%@",tableView.superview);
}
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    
}

@end