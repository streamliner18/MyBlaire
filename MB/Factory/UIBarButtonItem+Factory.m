//
//  UIBarButtonItem+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/25.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UIBarButtonItem+Factory.h"

@implementation UIBarButtonItem (Factory)
+ (UIBarButtonItem *)backBarbuttonItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIButton backButton]];
    return item;
}
+ (UIBarButtonItem *)categoryBarButtonItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIButton categoryButton]];
    return item;
}
+ (UIBarButtonItem *)searchBarButtonItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIButton searchButton]];
    return item;
}

@end
