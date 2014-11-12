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

+ (instancetype)userNameTextField
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyNext;
    return textField;
}

+ (instancetype)passwordTextField
{
    UITextField *textField = [self normalTextField];
    textField.returnKeyType = UIReturnKeyGo;
    return textField;
}

@end
