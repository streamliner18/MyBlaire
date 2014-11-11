//
//  Created by Tongtong Xu on 14-5-16.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTXProgressHUD : UIView

@property (nonatomic, strong) UIView *blackBackground;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UILabel *label;

+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view;
+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withTag:(NSInteger)tag;
+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withText:(NSString *)text;
+ (void)hideProgresssHUDInView:(UIView *)view;
+ (void)hideProgresssHUDInView:(UIView *)view withTag:(NSInteger)tag;

#pragma mark Using MBProgressHUD
+ (void)showMBProgressHUDInView:(UIView *)view;
+ (void)hideMBProgressHUDInView:(UIView *)view;
@end
