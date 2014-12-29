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
#import "UIImage+color.h"

#import <KLSwitch.h>

@interface MBRegisterViewController ()
@property (nonatomic, strong) UITextField *mailTextField;
@property (nonatomic, strong) UITextField *rePassWordTextField;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) KLSwitch *swichButton;
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
    self.userNameBackView.hidden = YES;
    self.passwordBackView.hidden = YES;
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    [self buildRegisterButton];
    [self buildOtherView];
    [self buildLoginButton];
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    
    @weakify (self);
    
    self.loginWithTokenBlock = ^(MBLoginType type, NSString *token){
        @strongify (self);
        [self showSpriteProgressHUD];
        [MBApi loginWithType:type userName:nil password:nil token:token handle:^(MBApiError *error) {
            [self dealWithLoginResult:error];
        }];
    };
    
    self.loginAfterRegisterBlock = ^(NSString *userName,NSString *password,MBApiError *error){
        if (error.code == 0) {
            [UIAlertView bk_showAlertViewWithTitle:@"" message:@"注册成功" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                @strongify (self);
                [self showSpriteProgressHUD];
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
    self.userNameTextField.frame = CGRectMake(15.5, 58, self.mbView.width-10, 43);
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(15.5, self.userNameTextField.bottom - 0.5, self.mbView.width - 15.5, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
    
    self.mailTextField = ({
        UITextField *textField = [UITextField mailTextFieldWithDelegate:self];
        textField.returnKeyType = UIReturnKeyNext;
        textField.frame = CGRectMake(self.userNameTextField.left, self.userNameTextField.bottom, self.userNameTextField.width, 43);
        textField;
    });
    [self.mbView addSubview:self.mailTextField];
    sep = [[UIView alloc] initWithFrame:CGRectMake(15.5, self.mailTextField.bottom - 0.5, self.mbView.width - 15.5, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
    
    self.passwordTextField.frame = CGRectMake(self.userNameTextField.left, self.mailTextField.bottom, self.userNameTextField.width, 43);
    sep = [[UIView alloc] initWithFrame:CGRectMake(15.5, self.passwordTextField.bottom - 0.5, self.mbView.width - 15.5, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
    self.rePassWordTextField = ({
        UITextField *textField = [UITextField passwordTextFieldWithDelegate:self];
        textField.frame = CGRectMake(self.userNameTextField.left, self.passwordTextField.bottom, self.userNameTextField.width, 43);
        textField.returnKeyType = UIReturnKeyDone;
        textField;
    });
    [self.mbView addSubview:self.rePassWordTextField];
    sep = [[UIView alloc] initWithFrame:CGRectMake(15.5, self.rePassWordTextField.bottom - 0.5, self.mbView.width - 15.5, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.5, self.rePassWordTextField.bottom, 36, 43)];
    sLabel.textColor = [UIColor colorWithHexString:@"#9497ab"];
    sLabel.text = @"同 意";
    sLabel.font = [UIFont systemFontOfSize:15];
//    sLabel.backgroundColor = [UIColor redColor];
    [self.mbView addSubview:sLabel];
    
    UILabel *ssLabel = [[UILabel alloc] initWithFrame:CGRectMake(sLabel.right + 5, self.rePassWordTextField.bottom, 100, 43)];
    ssLabel.textColor = [UIColor colorWithHexString:@"#597091"];
    ssLabel.text = @"服 务 条 款";
    ssLabel.font = [UIFont systemFontOfSize:15];
    ssLabel.userInteractionEnabled = YES;
    [ssLabel bk_whenTouches:1 tapped:1 handler:^{
        [self.navigationController pushViewController:[[NSClassFromString(@"MBServerTermsViewController") alloc] init] animated:YES];
    }];
    [self.mbView addSubview:ssLabel];
    
    sep = [[UIView alloc] initWithFrame:CGRectMake(15.5, sLabel.bottom - 0.5, self.mbView.width - 15.5, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
    
    self.swichButton = [[KLSwitch alloc] initWithFrame:CGRectMake(self.mbView.width - 125*0.5, self.rePassWordTextField.bottom+6.5, 52.5, 30)];
    self.swichButton.contrastColor = [UIColor colorWithHexString:@"#434a54"];
    [self.mbView addSubview:self.swichButton];
    
    
    
//    UITextField *enLabel = [UITextField normalTextField];
//    enLabel.frame = CGRectMake(self.userNameTextField.left, self.rePassWordTextField.bottom, self.userNameTextField.width, 43);
//    enLabel.userInteractionEnabled = NO;
//    [self.mbView addSubview:enLabel];
//
    
    self.userNameTextField.placeholder = @" 用 户 名";
    [self.userNameTextField setValue:V_COLOR(148, 159, 171, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    self.mailTextField.placeholder = @" Email";
    [self.mailTextField setValue:V_COLOR(148, 159, 171, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.placeholder = @" 密 码";
    [self.passwordTextField setValue:V_COLOR(148, 159, 171, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    self.rePassWordTextField.placeholder = @" 确 认 密 码";
    [self.rePassWordTextField setValue:V_COLOR(148, 159, 171, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
//    enLabel.placeholder = @"同 意 服 务 条 款";
//    [enLabel setValue:V_COLOR(148, 159, 171, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
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
    self.registButton.frame = CGRectMake(0.5*(self.view.width - 125), self.mbView.height - (88+60)*0.5 - (kiOS7?64:0), 125, 44);
    [self.registButton addTarget:self action:@selector(doRegistUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registButton];
}

- (void)buildLoginButton
{
    UILabel *label = [UILabel normalLabel];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, (82+192)*0.5, 58);
    label.textColor = [UIColor colorWithHexString:@"#597071"];
    label.text = @"  现有账号登录：";
    [self.mbView addSubview:label];
    
    
    UIButton *sina = [UIButton sinaLoginButton];
    [sina addTarget:self action:@selector(doSinaLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *qq = [UIButton qqLoginButton];
    [qq addTarget:self action:@selector(doQQLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    sina.frame = CGRectMake(label.right, label.top, 58, 58);
    qq.frame = CGRectMake(sina.right, sina.top, 58, 58);
    [self.mbView addSubview:sina];
    [self.mbView addSubview:qq];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, 57.5, self.mbView.width, 0.5)];
    sep.backgroundColor = V_COLOR(213, 217, 223, 1.0);
    [self.mbView addSubview:sep];
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
