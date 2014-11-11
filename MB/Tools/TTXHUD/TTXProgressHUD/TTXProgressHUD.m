//
//  Created by Tongtong Xu on 14-5-16.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "TTXProgressHUD.h"
#import <MBProgressHUD.h>

static NSInteger _width = 55;

#define MB_DEFAULT_PROGRESS_HUD_TAG 1000

@implementation TTXProgressHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _blackBackground = [[UIView alloc] init];
        _blackBackground.layer.cornerRadius = 4;
        _blackBackground.backgroundColor = [UIColor blackColor];
        _blackBackground.frame = CGRectMake((self.frame.size.width-_width)/2,
                                           (self.frame.size.height-_width)/2,
                                           _width,
                                           _width);
        [self addSubview:_blackBackground];
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicator startAnimating];
        _indicator.frame = CGRectMake((self.frame.size.width-20)/2,
                                     (self.frame.size.height-20)/2,
                                     20,
                                     20);
        [self addSubview:_indicator];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(_blackBackground.frame.origin.x,
                                                          _blackBackground.frame.origin.y,
                                                          _width,
                                                          20)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12];
        
        self.layer.zPosition = 10;
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view
{
    return [self showProgressHUDInView:view withTag:MB_DEFAULT_PROGRESS_HUD_TAG];
}

+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withTag:(NSInteger)tag
{
    [self hideProgresssHUDInView:view withTag:tag];
    TTXProgressHUD *me = [[self alloc] initWithFrame:view.bounds];
    me.blackBackground.alpha = 0.5;
    me.tag = tag;
    [view addSubview:me];
    return me;
}

+ (TTXProgressHUD *)showProgressHUDInView:(UIView *)view withText:(NSString *)text
{
    [self hideProgresssHUDInView:view withTag:MB_DEFAULT_PROGRESS_HUD_TAG];
    TTXProgressHUD *hud = [[TTXProgressHUD alloc] initWithFrame:view.bounds];
    hud.blackBackground.alpha = 0.5;
    hud.label.text = text;
    hud.tag = MB_DEFAULT_PROGRESS_HUD_TAG;
    [hud addSubview:hud.label];
    CGFloat width = [text sizeWithFont:hud.label.font].width + 20;
    
    //adjust frame;
    CGRect frame = hud.indicator.frame;
    frame.origin.y -= 7.5;
    hud.indicator.frame = frame;
    
    frame = hud.blackBackground.frame;
    if (width > _width) {
        CGFloat offset = (width-_width)/2;
        frame.origin.x -= offset;
        frame.size.width = width;
    }
    hud.blackBackground.frame = frame;
    
    frame = hud.label.frame;
    frame.origin.y = hud.indicator.frame.origin.y + hud.indicator.frame.size.height + 2;
    frame.origin.x = hud.blackBackground.frame.origin.x;
    frame.size.width = hud.blackBackground.frame.size.width;
    hud.label.frame = frame;
    
    [view addSubview:hud];
    return hud;
}

+ (void)hideProgresssHUDInView:(UIView *)view
{
    [self hideProgresssHUDInView:view withTag:MB_DEFAULT_PROGRESS_HUD_TAG];
}

+ (void)hideProgresssHUDInView:(UIView *)view withTag:(NSInteger)tag
{
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[TTXProgressHUD class]] && v.tag == tag) {
            [v removeFromSuperview];
        }
    }
}

#pragma mark Using MBProgressHUD

+ (void)showMBProgressHUDInView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideMBProgressHUDInView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
