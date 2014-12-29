//
//  TTXSpriteActitityIndicatorView.m
//  MB
//
//  Created by Tongtong Xu on 14/12/2.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXSpriteActitityIndicatorView.h"

@implementation TTXSpriteActitityIndicatorView

+ (instancetype)share
{
    TTXSpriteActitityIndicatorView *view = [[TTXSpriteActitityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < 39; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Preloader_4_000%d",i];
        [images addObject:[UIImage imageNamed:imageName]];
    }
    view.animationImages = images;
    view.animationDuration = 1.5;
    view.animationRepeatCount = MAXFLOAT;
    return view;
}

- (void)startLoading
{
    [self startAnimating];
}
- (void)stopLoading
{
    [self stopAnimating];
}

@end
