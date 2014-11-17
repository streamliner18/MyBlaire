//
//  TTXSearchBarTableViewController.h
//  TableViewSearchBar
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseTableViewController.h"

@interface TTXSearchBarTableViewController : TTXBaseTableViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    
}

- (void)scrollTableViewToSearchBarAnimated:(BOOL)animated; // Implemented by the subclasses

@property(nonatomic, strong, readonly) UISearchBar *searchBar;


- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView;
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0);
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0);
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0);
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0);

@end