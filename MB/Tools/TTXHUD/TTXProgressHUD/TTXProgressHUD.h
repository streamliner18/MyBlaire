//
//  Created by Tongtong Xu on 14-5-16.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTXActivityIndicatorView.h"
#import "TTXSpriteActitityIndicatorView.h"

typedef NS_ENUM(NSUInteger, TTXProgressHUDType) {
    TTXProgressHUDTypeNormal,
    TTXProgressHUDTypeSprite,
};

@interface TTXProgressHUD : UIView

@property (nonatomic, strong) UIView *blackBackground;
@property (nonatomic, strong) TTXActivityIndicatorView *indicator;
@property (nonatomic, strong) TTXSpriteActitityIndicatorView *spriteIndicator;
@property (nonatomic, strong) UILabel *label;



+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view type:(TTXProgressHUDType)type;
+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withTag:(NSInteger)tag type:(TTXProgressHUDType)type;
+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withText:(NSString *)text;
+ (void)hideProgresssHUDInView:(UIView *)view;
+ (void)hideProgresssHUDInView:(UIView *)view withTag:(NSInteger)tag;

#pragma mark Using MBProgressHUD
+ (void)showMBProgressHUDInView:(UIView *)view;
+ (void)hideMBProgressHUDInView:(UIView *)view;
@end
