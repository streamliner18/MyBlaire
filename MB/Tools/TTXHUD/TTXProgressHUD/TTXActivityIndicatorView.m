//
//  TTXActivityIndicatorView.m
//  adasdasd
//
//  Created by Tongtong Xu on 14/11/25.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXActivityIndicatorView.h"

@implementation TTXActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"LoadingImage"];
    }
    return self;
}

- (void)startLoading
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

@end
