//
//  MBRegisterViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBRegisterViewController.h"
#import "TTXLoginManager.h"
#import "NSString+Extent.h"

@interface MBRegisterViewController ()
@property (nonatomic, strong) UITextField *mailTextField;
@property (nonatomic, strong) UITextField *rePassWordTextField;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UISwitch *swichButton;
@end

@implementation MBRegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    [self buildRegisterButton];
    [self buildOtherView];
    [self buildLoginButton];
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    
    @weakify (self);
    
    self.loginWithTokenBlock = ^(MBLoginType type, NSString *token){
        @strongify (self);
        [self showProgressHUD];
        [MBApi loginWithType:type userName:nil password:nil token:token handle:^(MBApiError *error) {
            [self dealWithLoginResult:error];
        }];
    };
    
    self.loginAfterRegisterBlock = ^(NSString *userName,NSString *password,MBApiError *error){
        if (error.code == 0) {
            [UIAlertView bk_showAlertViewWithTitle:@"" message:@"注册成功" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                @strongify (self);
                [self showProgressHUD];
                [MBApi loginWithType:MBLoginTypeNormal userName:userName password:password token:nil handle:^(MBApiError *error) {
                    [self dealWithLoginResult:error];
                }];
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"" message:error.message delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:nil, nil] show];
        }
    };
}

- (void)buildOtherView
{
    self.userNameTextField.frame = CGRectMake(10, (iOS7?64:0) + 58, self.mbView.width-10, 58);
    self.mailTextField = ({
        UITextField *textField = [UITextField mailTextFieldWithDelegate:self];
        textField.returnKeyType = UIReturnKeyNext;
        textField.frame = CGRectMake(self.userNameTextField.left, self.userNameTextField.bottom, self.userNameTextField.width, 58);
        textField;
    });
    [self.mbView addSubview:self.mailTextField];
    self.passwordTextField.frame = CGRectMake(self.userNameTextField.left, self.mailTextField.bottom, self.userNameTextField.width, 58);
    self.rePassWordTextField = ({
        UITextField *textField = [UITextField passwordTextFieldWithDelegate:self];
        textField.frame = CGRectMake(self.userNameTextField.left, self.passwordTextField.bottom, self.userNameTextField.width, 58);
        textField.returnKeyType = UIReturnKeyDone;
        textField;
    });
    [self.mbView addSubview:self.rePassWordTextField];
    
    UITextField *enLabel = [UITextField normalTextField];
    enLabel.frame = CGRectMake(self.userNameTextField.left, self.rePassWordTextField.bottom, self.userNameTextField.width, 58);
    enLabel.userInteractionEnabled = NO;
    [self.mbView addSubview:enLabel];
    
    self.swichButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.mbView.width - 125*0.5, self.rePassWordTextField.bottom+12, 50, 40)];
    [self.mbView addSubview:self.swichButton];
    
    self.userNameTextField.placeholder = @"用户名";
    self.mailTextField.placeholder = @"Email";
    self.passwordTextField.placeholder = @"密码";
    self.rePassWordTextField.placeholder = @"确认密码";
    enLabel.placeholder = @"I agree to the Terms of Service";
}

- (void)keyboardShow:(NSNotification *)sender
{
    CGRect keyboardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rect = [self.mbView convertRect:self.rePassWordTextField.frame toView:self.view];
    if (CGRectGetMinY(keyboardFrame) < CGRectGetMaxY(rect)) {
        [UIView animateWithDuration:duration animations:^{
            self.mbView.top -= (CGRectGetMaxY(rect) + 10 - CGRectGetMinY(keyboardFrame));
        }];
    }
}

- (void)keyboardHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.mbView.top = 0;
    }];
}

- (void)buildRegisterButton
{
    self.registButton = [UIButton registButton];
    self.registButton.frame = CGRectMake(195*0.5, self.mbView.height - (88+57)*0.5, 125, 44);
    [self.registButton addTarget:self action:@selector(doRegistUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registButton];
}

- (void)buildLoginButton
{
    UILabel *label = [UILabel normalLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, iOS7?64:0, (82+192)*0.5, 58);
    label.text = @"现有账号登录：";
    [self.mbView addSubview:label];
    
    
    UIButton *sina = [UIButton sinaLoginButton];
    [sina addTarget:self action:@selector(doSinaLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *qq = [UIButton qqLoginButton];
    [qq addTarget:self action:@selector(doQQLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    sina.frame = CGRectMake(label.right, label.top, 58, 58);
    qq.frame = CGRectMake(sina.right, sina.top, 58, 58);
    [self.mbView addSubview:sina];
    [self.mbView addSubview:qq];
}

#pragma mark - actions

- (void)doRegistUser:(UIButton *)sender
{
    NSString *userName = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.mailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *repassword = [self.rePassWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (userName.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查用户名"];
        return;
    }
    if (email.length == 0 || ![email isValidateEmail]) {
        [self showAlertTitle:@"提示" message:@"请检查邮箱"];
        return;
    }
    if (password.length == 0) {
        [self showAlertTitle:@"提示" message:@"请检查密码"];
        return;
    }
    if (![password isEqualToString:repassword]) {
        [self showAlertTitle:@"提示" message:@"两次密码不一致"];
        return;
    }
    if (!self.swichButton.isOn) {
        [self showAlertTitle:@"提示" message:@"请同意条款"];
        return;
    }
    @weakify(self);
    [MBApi registerNewUserWithUserName:userName password:password email:email handle:^(MBApiError *error) {
        @strongify (self);
        if(self.loginAfterRegisterBlock){
            self.loginAfterRegisterBlock(userName,password,error);
        }
    }];
}

- (void)doSinaLoginAction:(UIButton *)sender
{
    [[TTXLoginManager shared] sinaLoginWithViewController:self];
}

- (void)doQQLoginAction:(UIButton *)sender
{
    [[TTXLoginManager shared] qqLoginWithViewController:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.mailTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [self.rePassWordTextField becomeFirstResponder];
    }else if (textField == self.mailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.rePassWordTextField) {
        [textField resignFirstResponder];
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

+ (NSString *)navigationItemTitle
{
    return @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
