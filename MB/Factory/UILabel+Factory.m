//
//  UILabel+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UILabel+Factory.h"

@implementation UILabel (Factory)
+ (instancetype)normalLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor yellowColor];
    return label;
}

+ (instancetype)userNameLabel
{
    UILabel *label = [self normalLabel];
    label.text = @"用户名";
    return label;
}

+ (instancetype)passwordLabel
{
    UILabel *label = [self normalLabel];
    label.text = @"密码";
    return label;
}

+ (instancetype)mailLabel
{
    UILabel *label = [self normalLabel];
    label.text = @"邮箱";
    return label;
}
@end
