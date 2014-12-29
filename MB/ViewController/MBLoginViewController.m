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
@property (nonatomic, strong) UIButton *loginButton;
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f8fa"];
    [self buildOtherView];
    [self buildLoginButton];
}

- (void)buildOtherView
{
    UIImage *image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"Login-new_10"];
    self.userNameBackView.hidden = YES;
    self.passwordBackView.hidden = YES;
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 124)*0.5, 186 - (IS_IPHONE_4_OR_LESS?88:0), 124, 58)];
    logo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginWelcomeMsg"];
    [self.mbView addSubview:logo];
    
    UIImageView *usernamelineimageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 228) * 0.5, logo.bottom + 78, 228, 40)];
    usernamelineimageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [self.mbView addSubview:usernamelineimageView];
    
    UIImageView *userNameLogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 40, 40)];
    userNameLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginUsernameIcon"];
    [usernamelineimageView addSubview:userNameLogo];
    
    UIImageView *passwordlineimageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 228) * 0.5, usernamelineimageView.bottom + 12, 228, 40)];
    passwordlineimageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [self.mbView addSubview:passwordlineimageView];
    
    UIImageView *passwordLogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 40, 40)];
    passwordLogo.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginPwdIcon"];
    [passwordlineimageView addSubview:passwordLogo];
    
    
    [self.mbView bringSubviewToFront:self.userNameTextField];
    [self.mbView bringSubviewToFront:self.passwordTextField];
    
    self.userNameTextField.frame = CGRectMake(usernamelineimageView.left + 45, usernamelineimageView.top, usernamelineimageView.width - 45, userNameLogo.height);
    self.userNameTextField.placeholder = @"用户名";
    [self.userNameTextField setValue:[UIColor colorWithHexString:@"#909399"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userNameTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

    
    
    self.passwordTextField.frame = CGRectMake(passwordlineimageView.left + 45, passwordlineimageView.top, passwordlineimageView.width - 45, passwordLogo.height);
    self.passwordTextField.placeholder = @"密码";
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"#909399"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

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
    _loginButton = [UIButton normalButton];
    _loginButton.frame = CGRectMake(0.5 * (self.view.width - 230), self.passwordTextField.bottom + 12, 230, 42.5);
    [_loginButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginButton"] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginButtonClicked"] forState:UIControlStateHighlighted];
    [_loginButton addTarget:self action:@selector(doLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:_loginButton];
    
    UIButton *registerButton = [UIButton normalButton];
    registerButton.frame = CGRectMake(0.5 * (self.view.width - 230), self.loginButton.bottom + 12, 230, 42.5);
    [registerButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginRegister"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"LoginView" imageName:@"LoginRegister_s"] forState:UIControlStateHighlighted];
    [registerButton addTarget:self action:@selector(doRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:registerButton];

    UIButton *forgetButton = [UIButton normalButton];
    forgetButton.frame = CGRectMake(registerButton.right - 70, registerButton.bottom + 16, 70, 15);
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetButton setTitleColor:[UIColor colorWithHexString:@"#909399"] forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    [forgetButton setTitle:@"忘记密码 ?" forState:UIControlStateHighlighted];
    [forgetButton addTarget:self action:@selector(findPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:forgetButton];
}

- (void)findPassword
{
    [self.navigationController pushViewController:[[NSClassFromString(@"MBFindPasswordViewController") alloc] init] animated:YES];
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
    [self showSpriteProgressHUD];
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
