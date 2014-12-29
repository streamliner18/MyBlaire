//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"
#import "TTXProgressHUD.h"
#import "TTXMessageHUD.h"

@interface TTXBaseViewController ()
@end

@implementation TTXBaseViewController

+ (instancetype)loadFromXib
{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)resetLeftBarButtonItem:(LeftBarButtonItemType)type
{
    switch (type) {
        case LeftBarButtonItemTypeBack:
        {
            UIBarButtonItem *backItem = [UIBarButtonItem backBarbuttonItem];
            [(UIButton *)backItem.customView addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = backItem;
            break;
        }
        default:
            break;
    }
}

- (void)backItemAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = [[self class] navigationItemTitle];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f2f6"];
    self.mbView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mbView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mbView];
    if (kiOS7) {
        self.automaticallyAdjustsScrollViewInsets = [[self class] automaticallyAdjustsScrollViewInsets];
    }
    [self configBackButton];
}

- (void)configBackButton
{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)showProgressHUD
{
    [TTXProgressHUD showProgressHUDInView:self.view type:TTXProgressHUDTypeSprite];
}

- (void)showSpriteProgressHUD
{
    [TTXProgressHUD showProgressHUDInView:self.view type:TTXProgressHUDTypeNormal];
}

- (void)hideProgressHUD;
{
    [TTXProgressHUD hideProgresssHUDInView:self.view];
}

#pragma mark - Show Message

- (void)showError:(NSError *)error message:(NSString *)message
{
    if (message.length == 0)
        message = ([error localizedDescription] ? :
                   [error localizedFailureReason] ? : message);
    [self showMessageHUDWithMessage:message];
}

- (void)showMessageHUDWithMessage:(NSString *)message
{
    if (message.length == 0) return;
    [TTXMessageHUD showMessageHUDWithMessage:message];
}

#pragma mark - Alert View

- (void)showAlertTitle:(NSString *)title message:(NSString *)message
{
    [self showAlertTitle:@"错误" message:message cancelTitle:@"确定" otherTitle:nil];
}

- (void)showAlertTitle:(NSString *)title message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:otherTitle, nil];
    [alert show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationItem.title = [[self class] navigationItemTitle];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationItem.title = [[self class] navigationItemDisappearTitle];
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"";
}

+ (NSString *)navigationItemDisappearTitle
{
    return [self navigationItemTitle];
}

+ (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

+ (UIColor *)viewBackgroundColor
{
    return [UIColor whiteColor];
}

- (void)dealloc
{
    NSLog(@"%@ release success",[self class]);
}

@end
