//
//  MBLoginViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBLoginViewController.h"
#import "MBRegisterViewController.h"

@interface MBLoginViewController ()
@end

@implementation MBLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
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
    [self buildOtherView];
    [self buildLoginButton];
}

- (void)buildOtherView
{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(189*0.5, 214, 132, 103 * 0.5)];
    logo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginWelcomeMsg"];
    [self.mbView addSubview:logo];
    
    UIImageView *userNameLogo = [[UIImageView alloc] initWithFrame:CGRectMake(87*0.5, self.mbView.height - (53+25+113+84+27+100+100)*0.5, 50, 50)];
    userNameLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginUsernameIcon"];
    [self.mbView addSubview:userNameLogo];
    
    UIImageView *passwordLogo = [[UIImageView alloc] initWithFrame:CGRectMake(87*0.5, self.mbView.height - (53+25+113+84+27+100)*0.5, 50, 50)];
    passwordLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginPwdIcon"];
    [self.mbView addSubview:passwordLogo];
    
    self.userNameTextField.frame = CGRectMake(userNameLogo.right, userNameLogo.top, self.mbView.width - userNameLogo.right, userNameLogo.height);
    self.userNameTextField.placeholder = @"用户名";
    self.passwordTextField.frame = CGRectMake(passwordLogo.right, passwordLogo.top, self.mbView.width - passwordLogo.right, passwordLogo.height);
    self.passwordTextField.placeholder = @"密码";
    
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
}

- (void)keyboardShow:(NSNotification *)sender
{
    CGRect keyboardFrame = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rect = [self.mbView convertRect:self.passwordTextField.frame toView:self.view];
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

#define kButtonMargin (20)

- (void)buildLoginButton
{
    UIButton *loginButton = [UIButton normalButton];
    loginButton.frame = CGRectMake(87 *0.5, self.mbView.height - (53+25+113+84)*0.5, 463*0.5, 42);
    [loginButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginButton"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginButtonPressed"] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(doLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:loginButton];
    
    UIButton *forgetButton = [UIButton normalButton];
    forgetButton.frame = CGRectMake(131*0.5-kButtonMargin*0.5, self.mbView.height - 53*0.5-kButtonMargin*0.5, 107*0.5+kButtonMargin, 25*0.5+kButtonMargin);
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码 ?" forState:UIControlStateHighlighted];
    [self.mbView addSubview:forgetButton];
    
    UIButton *registerButton = [UIButton normalButton];
    registerButton.frame = CGRectMake(self.mbView.width - (46+175)*0.5-kButtonMargin*0.5, self.mbView.height - 53*0.5-kButtonMargin*0.5, 23+kButtonMargin, 25*0.5+kButtonMargin);
    registerButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateHighlighted];
    [registerButton addTarget:self action:@selector(doRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:registerButton];
}

- (void)doRegisterAction:(UIButton *)sender
{
    MBRegisterViewController *viewController = [[MBRegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
        [self.passwordTextField resignFirstResponder];
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
