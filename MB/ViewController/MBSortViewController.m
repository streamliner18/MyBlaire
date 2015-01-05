//
//  MBSortViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/4.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortViewController.h"
#import "MBNewSortView.h"

@interface MBSortViewController ()
@property (nonatomic, strong) MBNewSortView *sortView;
@end

@implementation MBSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.sortView = [[MBNewSortView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 50, self.mbView.height)];
    [self.mbView addSubview:self.sortView];
}

- (void)reloadUserName
{
    [self.sortView reloadUserName];
}

- (BOOL)isAllClose
{
    return [self.sortView isAllClose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
