//
//  UILabel+Factory.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Factory)
+ (instancetype)normalLabel;
+ (instancetype)userNameLabel;
+ (instancetype)passwordLabel;
+ (instancetype)mailLabel;

@end
