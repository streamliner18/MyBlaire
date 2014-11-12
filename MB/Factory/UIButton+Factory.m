//
//  UIButton+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UIButton+Factory.h"

@implementation UIButton (Factory)

+ (instancetype)normalButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    return button;
}

+ (instancetype)textButtonWithNormalText:(NSString *)normalText highlightedText:(NSString *)highlightedText
{
    UIButton *button = [self normalButton];
    [button setTitle:normalText forState:UIControlStateNormal];
    [button setTitle:highlightedText forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)registButton
{
    UIButton *button = [self textButtonWithNormalText:@"注册" highlightedText:@"注册"];
    button.frame = CGRectMake(0, 0, 55, 30);
    return button;
}

+ (instancetype)loginButton
{
    UIButton *button = [self textButtonWithNormalText:@"登录" highlightedText:@"登录"];
    button.frame = CGRectMake(0, 0, 55, 30);
    return button;
}

+ (instancetype)sinaLoginButton
{
    UIButton *button = [self textButtonWithNormalText:@"微博登录" highlightedText:@"微博登录"];
    button.frame = CGRectMake(0, 0, 75, 30);
    return button;
}

+ (instancetype)qqLoginButton
{
    UIButton *button = [self textButtonWithNormalText:@"QQ登录" highlightedText:@"QQ登录"];
    button.frame = CGRectMake(0, 0, 65, 30);
    return button;
}

@end
