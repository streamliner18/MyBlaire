//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"
#import "TTXProgressHUD.h"
#import "TTXMessageHUD.h"
#import "MBOperationView.h"

@interface TTXBaseViewController ()<MBOperationViewDelegate>
@end

@implementation TTXBaseViewController

+ (instancetype)loadFromXib
{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MBOperationView *operationView = [[MBOperationView alloc] initWithFrame:self.view.bounds];
    operationView.delegate = self;
    self.view = operationView;
    [self configBackButton];
}

- (void)configBackButton
{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)showProgressHUD;
{
    [TTXProgressHUD showProgressHUDInView:self.view];
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

- (UIView *)operationView:(MBOperationView *)operationView hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

- (void)dealloc
{
    NSLog(@"%@ release success",[self class]);
}

@end
