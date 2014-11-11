//
//  Created by Tongtong Xu on 14-5-16.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import "TTXMessageHUD.h"
#import <MBProgressHUD.h>

@implementation TTXMessageHUD

+ (void)showMessageHUDWithMessage:(NSString *)message
{
    UIWindow *w = [[UIApplication sharedApplication] keyWindow];
    [self showMessageHUDWithMessage:message view:w duration:1.5];
}

+ (void)showMessageHUDWithMessage:(NSString *)message view:(UIView *)view duration:(CGFloat)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:time];
}

@end
