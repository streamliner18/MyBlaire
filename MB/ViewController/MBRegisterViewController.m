//
//  MBRegisterViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBRegisterViewController.h"

@interface MBRegisterViewController ()
@property (nonatomic, strong) UIView *mailBackView;
@property (nonatomic, strong) UITextField *mailTextField;
@property (nonatomic, strong) UIButton *registButton;
@end

@implementation MBRegisterViewController

- (UIView *)mailBackView
{
    if (!_mailBackView) {
        _mailBackView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _mailBackView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTextFieldBecomeResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (!iOS8) {
        [self.userNameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.mailTextField resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mailBackView.frame = CGRectMake(0, self.passwordBackView.bottom + 1, self.view.width, 44);
    [self.view addSubview:self.mailBackView];
    [self buildMailView];
    [self buildRegisterButton];
    [self buildLoginButton];
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    
//    @weakify (self);
    self.loginAfterRegisterBlock = ^(NSString *userName,NSString *password,MBApiError *error){
        if (error.code == 0) {
            [[[UIAlertView alloc] initWithTitle:@"" message:@"注册success" delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:nil, nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"" message:error.message delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:nil, nil] show];
        }
//        @strongify (self);
//        [self showProgressHUD];
//        [MBApi loginWithType:MBLoginTypeNormal userName:userName password:password token:nil handle:^(MBApiError *error) {
//            [self hideProgressHUD];
//        }];
    };
    @weakify (self);
    self.loginWithTokenBlock = ^(MBLoginType type, NSString *token){
        @strongify (self);
        [self showProgressHUD];
        [MBApi loginWithType:type userName:nil password:nil token:token handle:^(MBApiError *error) {
            [self dealWithLoginResult:error];
        }];
    };
}

- (void)buildMailView
{
    UILabel *label = [UILabel mailLabel];
    label.frame = CGRectMake(20, 11, 52, 22);
    [self.mailBackView addSubview:label];
    
    self.mailTextField = ({
        UITextField *textField = [UITextField mailTextFieldWithDelegate:self];
        textField.frame = CGRectMake(label.right + 10, label.top, self.view.width - label.right - 10 - 20, label.height);
        textField;
    });
    [self.mailBackView addSubview:self.mailTextField];
}

- (void)buildRegisterButton
{
    self.registButton = [UIButton registButton];
    self.registButton.center = CGPointMake(self.view.width * 0.5, self.mailBackView.bottom + 40);
    [self.registButton addTarget:self action:@selector(doRegistUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registButton];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.registButton.bottom + 20, self.view.width, 10)];
    imageview.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:imageview];
}

- (void)buildLoginButton
{
    UIButton *sina = [UIButton sinaLoginButton];
    [sina addTarget:self action:@selector(doSinaLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *qq = [UIButton qqLoginButton];
    [qq addTarget:self action:@selector(doQQLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    sina.center = CGPointMake(100, self.registButton.bottom + 50 + 10);
    qq.center = CGPointMake(100 + 100, self.registButton.bottom + 50 + 10);
    [self.view addSubview:sina];
    [self.view addSubview:qq];
}

#pragma mark - actions

- (void)doRegistUser:(UIButton *)sender
{
    NSString *userName = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.mailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (userName.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查用户名"];
        return;
    }
    if (password.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查密码"];
        return;
    }
    if (email.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查邮箱"];
        return;
    }
    
    if (self.registerActionBlock) {
        self.registerActionBlock(userName,password,email);
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [self.mailTextField becomeFirstResponder];
    }else if (textField == self.mailTextField) {
        [textField resignFirstResponder];
        [self doRegistUser:nil];
    }
    return YES;
}

//Rewrite

- (void)hideKeyBoard:(UITapGestureRecognizer *)sender
{
    if ([self.userNameTextField isFirstResponder] || [self.passwordTextField isFirstResponder] || [self.mailTextField isFirstResponder]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
}

- (void)setTextFieldBecomeResponder
{
    if (self.userNameTextField.text.length == 0) {
        [self.userNameTextField becomeFirstResponder];
    }else if (self.passwordTextField.text.length == 0) {
        [self.passwordTextField becomeFirstResponder];
    }else{
        [self.mailTextField becomeFirstResponder];
    }
}

+ (NSString *)navigationItemTitle
{
    return @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
