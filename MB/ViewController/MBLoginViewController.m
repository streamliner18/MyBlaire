//
//  MBLoginViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBLoginViewController.h"

@interface MBLoginViewController ()

@end

@implementation MBLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setTextFieldBecomeResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!iOS8) {
        [self.userNameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLoginButton];
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
    if (self.sinaLoginActionBlock) {
        self.sinaLoginActionBlock();
    }
}

- (void)doQQLoginAction:(UIButton *)sender
{
    if (self.qqLoginActionBlock) {
        self.qqLoginActionBlock();
    }
}

#pragma mark - textfielddelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [self doLoginAction];
    }
    return YES;
}

- (void)doLoginAction
{
    NSString *userName = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (userName.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查用户名"];
        return;
    }
    if (password.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查密码"];
        return;
    }
    [self showProgressHUD];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [MBApi loginWithType:MBLoginTypeNormal userName:userName password:password token:nil handle:^(MBApiError *error) {
        [self dealWithLoginResult:error];
    }];
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)sender
{
    if ([self.userNameTextField isFirstResponder] || [self.passwordTextField isFirstResponder]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
}

- (void)setTextFieldBecomeResponder
{
    if (self.userNameTextField.text.length == 0) {
        [self.userNameTextField becomeFirstResponder];
    }else{
        [self.passwordTextField becomeFirstResponder];
    }
}

+ (NSString *)navigationItemTitle
{
    return @"登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
