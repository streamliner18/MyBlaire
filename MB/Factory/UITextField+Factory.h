//
//  UITextField+Factory.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTXPasswordTextField : UITextField

@end


@interface UITextField (Factory)
+ (instancetype)normalTextField;
+ (instancetype)userNameTextFieldWithDelegate:(id <UITextFieldDelegate>) object;
+ (instancetype)passwordTextFieldWithDelegate:(id <UITextFieldDelegate>) object;
+ (instancetype)mailTextFieldWithDelegate:(id <UITextFieldDelegate>) object;
@end

