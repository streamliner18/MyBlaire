//
//  MBFeedBackViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/3.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBFeedBackViewController.h"

@interface MBFeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong) UITextField *nameField,*mailField;
@property (nonatomic, strong) UITextView *infoView;
@end

@implementation MBFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    self.title = @"意 见 反 馈";
//    CGFloat totalWidth = self.view.width - 80;
//    CGFloat textFieldWidth = (totalWidth - 22) / 2.0;
//    
//    
//    UILabel *nameLabel = ({
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, (kiOS7?64:0)+19, textFieldWidth, 12)];
//        label.text = @"姓名";
//        label.font = [UIFont systemFontOfSize:11];
//        label;
//    });
//    [self.mbView addSubview:nameLabel];
//    
//    self.nameField = ({
//        UITextField *view = [[UITextField alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + 8, textFieldWidth, 15)];
//        view.delegate = self;
//        view.returnKeyType = UIReturnKeyNext;
//        view.backgroundColor = kFeedBackNameFieldBackgroundColor;
//        view.layer.borderWidth = 0.5;
//        view;
//    });
//    [self.mbView addSubview:self.nameField];
//    
//    
//    self.mailField = ({
//        UITextField *view = [[UITextField alloc] initWithFrame:CGRectMake(self.nameField.right + 22, nameLabel.bottom + 8, textFieldWidth, 15)];
//        view.delegate = self;
//        view.returnKeyType = UIReturnKeyNext;
//        view.backgroundColor = kFeedBackNameFieldBackgroundColor;
//        view.layer.borderWidth = 0.5;
//        view;
//    });
//    [self.mbView addSubview:self.mailField];
//    UILabel *mailLabel = ({
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.mailField.left, (kiOS7?64:0)+19, textFieldWidth, 12)];
//        label.font = [UIFont systemFontOfSize:11];
//        label.text = @"e~mail";
//        label;
//    });
//    [self.mbView addSubview:mailLabel];
//    
//    UILabel *infoLabel = ({
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.nameField.left, self.nameField.bottom + 9, textFieldWidth, 12)];
//        label.font = [UIFont systemFontOfSize:11];
//        label.text = @"信息";
//        label;
//    });
//    [self.mbView addSubview:infoLabel];
    
    self.infoView = ({
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(41.5, 21.5, self.mbView.width - 82.5, 194)];
        textView.returnKeyType = UIReturnKeyDone;
        textView.backgroundColor = [UIColor colorWithHexString:@"#c8d7d4"];//kFeedBackNameFieldBackgroundColor;
        textView.font = [UIFont systemFontOfSize:15];
        textView.delegate = self;
        textView;
    });
    [self.mbView addSubview:self.infoView];
    
    UIButton *senderButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.mbView.width - 44 - 32, self.infoView.bottom + 22, 32, 17);
        [button setTitle:@"发送" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:[UIColor colorWithHexString:@"#434a54"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(feedBack:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.mbView addSubview:senderButton];
    
    [self.mbView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewResignFirstResponder)]];
}

- (void)feedBack:(UIButton *)sender
{
    if ([self.infoView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        [MBApi feedbackWithMesage:[self.infoView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] completionHandle:^(MBApiError *error) {
            [self showMessageHUDWithMessage:error.message];
            if (error.code == MBApiCodeSuccess) {
                self.infoView.text = nil;
            }
        }];
    }else{
        [self showError:nil message:@"请输入反馈内容"];
    }
}

- (void)viewResignFirstResponder
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField == self.nameField) {
//        [self.mailField becomeFirstResponder];
//    }else if (textField == self.mailField) {
//        [self.infoView becomeFirstResponder];
//    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
