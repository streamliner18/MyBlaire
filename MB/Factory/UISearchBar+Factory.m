//
//  UISearchBar+Factory.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "UISearchBar+Factory.h"

@implementation UISearchBar (Factory)

+ (instancetype)normalSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ([ searchBar respondsToSelector : @selector (barTintColor)]) {
        float iosversion7_1 = 7.1;
        if (version >= iosversion7_1) {
            //iOS7.1
            [[[[searchBar.subviews firstObject] subviews] firstObject] removeFromSuperview];
            [searchBar setBackgroundColor:[UIColor clearColor]];
        } else {
            //iOS7.0
            [searchBar setBarTintColor:[UIColor clearColor]];
            [searchBar setBackgroundColor:[UIColor clearColor]];
        }
    } else {
        //iOS7.0 以下
        [[searchBar.subviews firstObject] removeFromSuperview];
        [searchBar setBackgroundColor:[UIColor clearColor]];
    }
    [searchBar sizeToFit];
    return searchBar;
}

+ (instancetype)homePageSearchBar
{
    UISearchBar *searchBar = [self normalSearchBar];
    searchBar.placeholder = @"Search";
    return searchBar;
}
@end
