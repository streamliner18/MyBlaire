//
//  UIButton+Factory.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Factory)
+ (instancetype)normalButton;
+ (instancetype)registButton;
+ (instancetype)loginButton;
+ (instancetype)sinaLoginButton;
+ (instancetype)qqLoginButton;
@end
