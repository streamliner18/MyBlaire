//
//  MBFindPasswordViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/21.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBFindPasswordViewController.h"
#import "NSString+Extent.h"

@interface MBFindPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation MBFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f8fa"];
    self.navigationItem.title = @"找 回 密 码";
    
    UIImageView *lineimageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 228) * 0.5, 48, 228, 40)];
    lineimageView.userInteractionEnabled = YES;
    lineimageView.image = [[UIImage bt_imageWithBundleName:@"Source" filepath:@"FindPassword" imageName:@"Find-password-new_10"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [self.mbView addSubview:lineimageView];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    icon.image =[UIImage bt_imageWithBundleName:@"Source" filepath:@"FindPassword" imageName:@"Find-password-new_07"];
    [lineimageView addSubview:icon];
    
    _textField = [UITextField normalTextField];
    _textField.delegate = self;
    _textField.frame = CGRectMake(45, 0, lineimageView.width - 45, 40);
    _textField.textColor = [UIColor colorWithHexString:@"#606266"];
    _textField.font = [UIFont systemFontOfSize:16];
    [_textField setValue:[UIColor colorWithHexString:@"#909399"] forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _textField.placeholder = @"请填写您的Email地址";
    [lineimageView addSubview:_textField];
    
    UIButton *send = [UIButton normalButton];
    send.frame = CGRectMake(0.5 * (self.view.width - 230), lineimageView.bottom + 24, 230, 42.5);
    [send setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"FindPassword" imageName:@"Find-password-new_11"] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"FindPassword" imageName:@"Find-password-new-hold_11"] forState:UIControlStateHighlighted];
    [send addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:send];
    
    [self.mbView bk_whenTouches:1 tapped:1 handler:^{
        [_textField resignFirstResponder];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
}

- (void)sendAction
{
    if([_textField.text isValidateEmail]){
        [MBApi findPasswordWithEmail:_textField.text completionHandle:^(MBApiError *error) {
            [self showAlertTitle:@"" message:error.message];
        }];
    }else{
        [self showMessageHUDWithMessage:@"请输入有效邮箱地址"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIFont* font = [UIFont systemFontOfSize:18];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#525a66"]};
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
