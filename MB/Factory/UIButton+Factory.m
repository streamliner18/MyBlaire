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
    button.backgroundColor = [UIColor clearColor];
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
    UIButton *button = [self normalButton];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"RegisterButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"RegisterButtonPressed"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 125, 44);
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
    UIButton *button = [self normalButton];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"SNSWeiboButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"SNSWeiboButtonPressed"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 58, 58);
    return button;
}

+ (instancetype)qqLoginButton
{
    UIButton *button = [self normalButton];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"SNSQQButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"RegisterView" imageName:@"SNSQQButtonPressed"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 58, 58);
    return button;
}

+ (instancetype)backButton
{
    UIButton *button = [self normalButton];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Common" imageName:@"BackButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Common" imageName:@"BackButtonPressed"] forState:UIControlStateHighlighted];
    return button;
}

+ (instancetype)sortButton
{
    UIButton *button = [self textButtonWithNormalText:@"sort" highlightedText:@"sort"];
    button.frame = CGRectMake(0, 0, 44, 44);
    return button;
}

@end
