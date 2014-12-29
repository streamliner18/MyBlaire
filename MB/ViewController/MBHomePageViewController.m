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
#import "MBCategoryView.h"
#import "MBHomePageDataManager.h"
#import "MBHomePageCellNewModel.h"

#import "MBGoodsInfoViewController.h"

#import "MBHomePageViewDiscountCell.h"
#import "MBHomePageViewPopularCell.h"
#import "MBHomePageViewStarSameCell.h"

#import "MBSearchViewController.h"
#import "MBHomePageSortResultViewController.h"
#import "MBNewSortView.h"
#import "MBSearchViewController.h"
#import "MLBlackTransition.h"

typedef void(^MBKeywordsBlock)(NSArray *keys);

@interface MBHomePageViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) MBSearchView *searchView;

@property (nonatomic, strong) MBCategoryView *categoryView;
@property (nonatomic) BOOL categoryViewShowed;

@property (nonatomic, strong) MBNewSortView *sortView;
@property (nonatomic) BOOL sortViewShowed;

@end

@implementation MBHomePageViewController

- (void)sortSearch
{
    MBHomePageSortResultViewController *vc = [[MBHomePageSortResultViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

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
}

- (void)loadDataSource
{
    [self showProgressHUD];
    [MBHomePageDataManager shareData:^(MBApiError *error, NSArray *discountArray, NSArray *popularArray, NSArray *starSameArray) {
        [self hideProgressHUD];
        if (error.code == MBApiCodeUnLogin) {
            [MB_Model clear];
            [LoginManager showLoginView];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource) name:kMBMODELUSERDIDLOGIN object:nil];
        }else{
            NSMutableArray *array = @[].mutableCopy;
            [array addObject:[MBHomePageCellNewModelDiscount shareWithArray:discountArray]];
            [array addObject:[MBHomePageCellNewModelPopular shareWithArray:popularArray]];
            [array addObjectsFromArray:[MBHomePageCellNewModelStarSame shareWithArray:starSameArray]];
            self.dataSource = [NSArray arrayWithArray:array];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:MB_ShouldHideLaunchView() object:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController enabledMLBlackTransition:NO];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, self.mbView.width, self.mbView.height - (kiOS7 ? 64 : 0) - 49);
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#e2e4ec"];
    [self loadDataSource];
    
    //调整height
    
    self.navigationItem.titleView = [self topImageView];
    
    UIBarButtonItem *categoryItem = [UIBarButtonItem categoryBarButtonItem];
    [(UIButton *)categoryItem.customView addTarget:self action:@selector(showHideSortView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = categoryItem;
    
    UIBarButtonItem *searchItem = [UIBarButtonItem searchBarButtonItem];
    [(UIButton *)searchItem.customView addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = searchItem;
}

- (UIImageView *)topImageView
{
    UIImageView *topLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 61, 29)];
    topLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Home" imageName:@"TopLogo"];
    return topLogo;
}

- (MBCategoryView *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[MBCategoryView alloc] initWithFrame:CGRectMake(-self.view.width, kiOS7?64:0, self.view.width, self.view.height - 44 - (kiOS7?64:0))];
    }
    return _categoryView;
}

- (MBNewSortView *)sortView
{
    if (!_sortView) {
        _sortView = [[MBNewSortView alloc] initWithFrame:CGRectMake(-self.view.width, kiOS7?64:0, self.view.width, self.view.height - 44 - (kiOS7?64:0))];
    }
    return _sortView;
}

- (void)reloadDateAfterLoginOut
{
    [self.sortView removeFromSuperview];
    self.sortView = nil;
    [self loadDataSource];
}

- (void)showHideSortView
{
    if (self.mm_drawerController.openSide) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }else{
        [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (void)showHideCategoryView
{
    self.navigationController.view.userInteractionEnabled = NO;
    if (self.categoryViewShowed) {
        [UIView animateWithDuration:0.3 animations:^{
            self.categoryView.center = CGPointMake(self.categoryView.center.x - self.categoryView.width, self.categoryView.center.y);
            self.navigationItem.titleView = [self topImageView];
        }completion:^(BOOL finished) {
            self.categoryViewShowed = NO;
            self.navigationController.view.userInteractionEnabled = YES;
        }];
    }else{
        if (!self.categoryView.superview) {
            [self.mbView addSubview:self.categoryView];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationItem.titleView = nil;
            self.categoryView.center = CGPointMake(self.categoryView.center.x + self.categoryView.width, self.categoryView.center.y);
            self.title = @"分类";
        }completion:^(BOOL finished) {
            self.categoryViewShowed = YES;
            self.navigationController.view.userInteractionEnabled = YES;
        }];
    }
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isMemberOfClass:[MBHomePageCellNewModelDiscount class]]) {
        return @"MBHomePageViewDiscountCell";
    }else if ([object isMemberOfClass:[MBHomePageCellNewModelPopular class]]) {
        return @"MBHomePageViewPopularCell";
    }else if ([object isMemberOfClass:[MBHomePageCellNewModelStarSame class]]) {
        return @"MBHomePageViewStarSameCell";
    }
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
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isMemberOfClass:[MBHomePageCellNewModelDiscount class]]) {
        return [MBHomePageViewDiscountCell cellHeightWithModel:object];
    }else if ([object isMemberOfClass:[MBHomePageCellNewModelPopular class]]) {
        return [MBHomePageViewPopularCell cellHeightWithModel:object];
    }else if ([object isMemberOfClass:[MBHomePageCellNewModelStarSame class]]) {
        return [MBHomePageViewStarSameCell cellHeightWithModel:object];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[MBHomePageViewDiscountCell class]]) {
        MBHomePageViewDiscountCell *discountCell = cell;
        @weakify(self);
        discountCell.tapBlock = ^(MBProductModel *model){
            @strongify(self);
            [self turnToGoodsInfo:model];
        };
    }else if ([cell isKindOfClass:[MBHomePageViewPopularCell class]]) {
        MBHomePageViewPopularCell *popularCell = cell;
        @weakify(self);
        popularCell.tapBlock = ^(MBProductModel *model){
            @strongify(self);
            [self turnToGoodsInfo:model];
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isMemberOfClass:[MBHomePageCellNewModelStarSame class]]) {
        [self turnToGoodsInfo:((MBHomePageCellNewModelStarSame *)object).product];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)turnToGoodsInfo:(MBProductModel *)model
{
    if ([model isKindOfClass:[MBProductModel class]]) {
        MBGoodsInfoViewController *info = [[MBGoodsInfoViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:info animated:YES];
    }
}

- (void)showSearchView
{
    UIImage *image = [self screenShot];
    MBSearchViewController *vc = [[MBSearchViewController alloc] initWithImage:image];
    [self.navigationController pushViewController:vc animated:NO];
}

- (UIImage *)screenShot{
    
    UIGraphicsBeginImageContext(self.tableView.frame.size); //currentView 当前的view
    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"蜜 包";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.tabBarController s
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
