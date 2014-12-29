//
//  TTXBaseNavigationController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseNavigationController.h"
#import "MBShareViewController.h"
#import "MBFeedBackViewController.h"
#import "MBHomePageSortResultViewController.h"

@interface TTXBaseNavigationController ()

@end

@implementation TTXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isMemberOfClass:[MBHomePageSortResultViewController class]] || [viewController isMemberOfClass:[MBShareViewController class]] || [viewController isMemberOfClass:[MBFeedBackViewController class]]) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
