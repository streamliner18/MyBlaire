//
//  UITextField+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UITextField+Factory.h"

@implementation UITextField (Factory)

+ (instancetype)normalTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
//    textField.backgroundColor = [UIColor redColor];
    return textField;
}

+ (instancetype)userNameTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyNext;
    textField.delegate = object;
    return textField;
}

+ (instancetype)passwordTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [self normalTextField];
    textField.secureTextEntry = YES;
    textField.delegate = object;
    textField.returnKeyType = UIReturnKeyGo;
    return textField;
}

+ (instancetype)mailTextFieldWithDelegate:(id<UITextFieldDelegate>)object
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = object;
    return textField;
}

@end
