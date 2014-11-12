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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.mailBackView.frame = CGRectMake(0, self.passwordBackView.bottom + 1, self.view.width, 44);
    [self.view addSubview:self.mailBackView];
    [self buildMailView];

    self.passwordTextField.returnKeyType = UIReturnKeyNext;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [self.mailTextField becomeFirstResponder];
    }else if (textField == self.mailTextField) {
        [textField resignFirstResponder];
        if (self.registerActionBlock) {
            self.registerActionBlock();
        }
    }
    return YES;
}

- (UIView *)operationView:(MBOperationView *)operationView hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self.userNameTextField isFirstResponder] || [self.passwordTextField isFirstResponder] || [self.mailTextField isFirstResponder]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    return [super operationView:operationView hitTest:point withEvent:event];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
