//
//  MBServerTermsViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/23.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBServerTermsViewController.h"

@interface MBServerTermsViewController ()

@end

@implementation MBServerTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    self.navigationItem.title = @"服 务 条 款";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mbView.width, 40)];
    label.textColor = [UIColor colorWithHexString:@"#949fab"];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"bllah blah blah";
    [self.mbView addSubview:label];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
