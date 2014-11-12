//
//  MBLRBaseViewController.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXBaseViewController.h"

@interface MBLRBaseViewController : TTXBaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIView *userNameBackView;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UIView *passwordBackView;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic,copy) TTXActionBlock registerActionBlock;
@property (nonatomic,copy) TTXActionBlock loginActionBlock;
@property (nonatomic,copy) TTXActionBlock sinaLoginActionBlock;
@property (nonatomic,copy) TTXActionBlock qqLoginActionBlock;
@end
