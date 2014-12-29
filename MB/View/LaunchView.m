//
//  LaunchView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/25.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "LaunchView.h"
#import "TTXActivityIndicatorView.h"

@implementation LaunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:frame];
        NSString *imageName;
        if (IS_IPHONE_6P) {
            imageName = @"LaunchDefault(iphone6+)";
        }else if (IS_IPHONE_6){
            imageName = @"LaunchDefault(iphone6)";
        }else if (IS_IPHONE_5) {
            imageName = @"LaunchDefault(iphone5)";
        }else{
            imageName = @"LaunchDefault(iphone4)";
        }
        icon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
        [self addSubview:icon];
        
        TTXActivityIndicatorView *activity = [[TTXActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
        activity.center = CGPointMake(self.width * 0.5, (424+112+31+46+55+42) / 2.0);
        [self addSubview:activity];
        [activity startLoading];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSelf:) name:MB_ShouldHideLaunchView() object:nil];
    }
    return self;
}

- (void)hideSelf:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
