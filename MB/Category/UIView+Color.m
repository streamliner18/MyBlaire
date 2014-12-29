//
//  UIView+Color.m
//  VacationIOS
//
//  Created by 巩 鹏军 on 14-4-15.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "UIView+Color.h"

@implementation UIView (Color)

+ (UIView *)viewWithColor:(UIColor *)color;
{
    UIView *colorView = [[UIView alloc] init];
    colorView.backgroundColor = color;
    return colorView;
}

@end
