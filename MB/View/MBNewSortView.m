//
//  MBNewSortView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/28.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBNewSortView.h"
#import "MBSorter.h"
#import "MBSortModel.h"
#import "MBSortHeaderCell.h"
#import "MBSortPriceOptionCell.h"
#import "MBSortDiscountCell.h"
#import "MBSortColorCell.h"

#import "MBHomePageViewController.h"

@interface MBNewSortView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *listView;

@end

@implementation MBNewSortView

- (void)reloadUserName
{
    UILabel *label = (UILabel *)[self.listView.tableHeaderView viewWithTag:1];
    label.text = [NSString stringWithFormat:@"Hi,%@",MB_Model.userName];
}

- (UITableView *)listView
{
    if (!_listView) {
        _listView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 44) style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableHeaderView = [self headerView];
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView;
        });
    }
    return _listView;
}

- (UIView *)headerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 69)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(21, 28, 37, 37)];
    imageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"Refine-Expanded-new_03"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12, imageView.top, 200, imageView.height)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor colorWithHexString:@"#525a66"];
    label.tag = 1;
    label.text = [NSString stringWithFormat:@"Hi, %@",MB_Model.userName];
    [view addSubview:label];
    
    return view;
}

- (UIView *)footerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *resetButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(21, 0, 66, 24);
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"ResetButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"ResetButtonClicked"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [view addSubview:resetButton];
    UIButton *setButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(resetButton.right + 21, resetButton.top, 66, 24);
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"FilterButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"FilterButtonClicked"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [view addSubview:setButton];
    return view;
}

- (void)resetAction:(UIButton *)sender
{
    [[MBSorter shared] reset];
    [self.listView reloadData];
}

- (void)setAction:(UIButton *)sender
{
    MMDrawerController *menu = (MMDrawerController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    UITabBarController *tab = (UITabBarController *)menu.centerViewController;
    [menu closeDrawerAnimated:YES completion:^(BOOL finished) {
        tab.selectedIndex = 0;
        MBHomePageViewController *homePage = [((UINavigationController *)[[tab viewControllers] objectAtIndex:0]).viewControllers firstObject];
        [homePage sortSearch];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#fcfcfa"];
        [[MBSorter shared] buildSorters];

        self.dataSource = [MBSorter shared].defaultSorters.mutableCopy;
        [self addSubview:self.listView];
        
        [self addSubview:[self footerView]];
        self.backgroundColor = [UIColor colorWithHexString:@"#fcfcfa"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[MBSortModel class]]) {
        MBSortHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HEADERCELL"];
        if (!cell) {
            cell = [[MBSortHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HEADERCELL"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.model = object;
        return cell;
    }else{
        MBSortSubModel *model = object;
        if (model.categoryType == MBSortModelTypePrice) {
            MBSortPriceOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PRICECELL"];
            if (!cell) {
                cell = [[MBSortPriceOptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PRICECELL"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];

            }
            cell.model = object;
            
            return cell;
        } else if (model.categoryType == MBSortModelTypeDiscount) {
            MBSortDiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DISCOUNTCELL"];
            if (!cell) {
                cell = [[MBSortDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DISCOUNTCELL"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];

            }
            cell.model = object;
            return cell;
        } else if (model.categoryType == MBSortModelTypeColor) {
            MBSortColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COLORCELL"];
            if (!cell) {
                cell = [[MBSortColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"COLORCELL"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
            }
            cell.model = object;
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[MBSortModel class]]) {
        MBSortModel *model = object;
        if (model.type == MBSortModelTypePrice) {
            if (model.isOpen) {
                [self.dataSource removeObjectAtIndex:indexPath.row+1];
                [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = NO;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                [self.dataSource insertObject:[MBSorter shared].currentPriceSortModel atIndex:indexPath.row+1];
                [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = YES;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else if (model.type == MBSortModelTypeDiscount) {
            if (model.isOpen) {
                [self.dataSource removeObjectAtIndex:indexPath.row+1];
                [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = NO;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                [self.dataSource insertObject:[MBSorter shared].currentDiscountSortModel atIndex:indexPath.row+1];
                [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = YES;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else if (model.type == MBSortModelTypeColor) {
            if (model.isOpen) {
                [self.dataSource removeObjectAtIndex:indexPath.row+1];
                [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = NO;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                [self.dataSource insertObject:[MBSorter shared].currentColorSortModel atIndex:indexPath.row+1];
                [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
                model.isOpen = YES;
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataSource objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[MBSortModel class]]) {
        return [MBSortHeaderCell cellHeightWithModel:object];
    }else {
        MBSortSubModel *model = object;
        if (model.categoryType == MBSortModelTypePrice) {
            return [MBSortPriceOptionCell cellHeightWithModel:object];
        }else if (model.categoryType == MBSortModelTypeDiscount) {
            return [MBSortDiscountCell cellHeightWithModel:object];
        }else if (model.categoryType == MBSortModelTypeColor) {
            return [MBSortColorCell cellHeightWithModel:object];
        }
    }
    return 0;
}

- (BOOL)isAllClose
{
    __block BOOL isAllClose = YES;
    [self.dataSource enumerateObjectsUsingBlock:^(MBSortModel *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MBSortModel class]] && obj.isOpen) {
            isAllClose = NO;
            *stop = YES;
        }
    }];
    return isAllClose;
}

@end
