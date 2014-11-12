//
//  MBLoginViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBLoginViewController.h"

@interface MBLoginViewController ()
@property (nonatomic, strong) UIView *userNameBackView;
@property (nonatomic, strong) UIView *passwordBackView;
@end

@implementation MBLoginViewController

- (UIView *)userNameBackView
{
    if (!_userNameBackView) {
        _userNameBackView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _userNameBackView;
}

- (UIView *)passwordBackView
{
    if (!_passwordBackView) {
        _passwordBackView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _passwordBackView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:[self.navigationController.viewControllers indexOfObject:self]%2==0 animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.userNameBackView.frame = CGRectMake(0, 64, self.view.width, 44);
    self.passwordBackView.frame = CGRectMake(0, 64+1+44, self.view.width, 44);
    [self.view addSubview:self.userNameBackView];
    [self.view addSubview:self.passwordBackView];
    [self buildUserNameView];
    [self buildPasswordView];
    [self buildLoginButton];
}

- (void)buildUserNameView
{
    UILabel *label = [UILabel userNameLabel];
    label.frame = CGRectMake(20, 11, 52, 22);
    [self.userNameBackView addSubview:label];
    
    UITextField *textField = [UITextField userNameTextField];
    textField.frame = CGRectMake(label.right + 10, label.top, self.view.width - label.right - 10 - 20, label.height);
    [self.userNameBackView addSubview:textField];
}

- (void)buildPasswordView
{
    UILabel *label = [UILabel passwordLabel];
    label.frame = CGRectMake(20, 11, 52, 22);
    [self.passwordBackView addSubview:label];
    
    UITextField *textField = [UITextField passwordTextField];
    textField.frame = CGRectMake(label.right + 10, label.top, self.view.width - label.right - 10 - 20, label.height);
    [self.passwordBackView addSubview:textField];
}

- (void)buildLoginButton
{
    UIButton *sina = [UIButton sinaLoginButton];
    [sina addTarget:self action:@selector(doSinaLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *qq = [UIButton qqLoginButton];
    [qq addTarget:self action:@selector(doQQLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    sina.center = CGPointMake(100, self.passwordBackView.bottom + 40);
    qq.center = CGPointMake(100 + 100, self.passwordBackView.bottom + 40);
    [self.view addSubview:sina];
    [self.view addSubview:qq];
}

- (void)doSinaLoginAction:(UIButton *)sender
{
    if (_sinaLoginActionBlock) {
        _sinaLoginActionBlock();
    }
}

- (void)doQQLoginAction:(UIButton *)sender
{
    if (_qqLoginActionBlock) {
        _qqLoginActionBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
