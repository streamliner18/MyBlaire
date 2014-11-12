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
    [self setTextFieldBecomeResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
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
        //login
        if (self.loginActionBlock) {
            self.loginActionBlock();
        }
    }
    return YES;
}

- (UIView *)operationView:(MBOperationView *)operationView hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self.userNameTextField isFirstResponder] || [self.passwordTextField isFirstResponder]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    return [super operationView:operationView hitTest:point withEvent:event];
}

- (void)setTextFieldBecomeResponder
{
    if (self.userNameTextField.text.length == 0) {
        [self.userNameTextField becomeFirstResponder];
    }else{
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
