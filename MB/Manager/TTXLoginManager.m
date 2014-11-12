//
//  TTXLoginManager.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "TTXLoginManager.h"
#import <UMengSocial/UMSocialControllerService.h>
#import <UMengSocial/UMSocialSnsPlatformManager.h>
#import <UMengSocial/UMSocialAccountManager.h>

@interface TTXLoginManager ()<UMSocialUIDelegate>

@end

@implementation TTXLoginManager

SINGLETON_IMPLEMENTATION(TTXLoginManager)

- (void)sinaLoginWithViewController:(UIViewController *)viewController
{
    [self loginWithType:UMSocialSnsTypeSina viewController:viewController];
}

- (void)qqLoginWithViewController:(UIViewController *)viewController
{
    [self loginWithType:UMSocialSnsTypeMobileQQ viewController:viewController];
}

- (void)loginWithType:(UMSocialSnsType)type viewController:(UIViewController *)viewController
{
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:type];
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"login response is %@",response);
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
        }
        //这里可以获取到腾讯微博openid,Qzone的token等
        /*
         if ([platformName isEqualToString:UMShareToTencent]) {
         [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
         NSLog(@"get openid  response is %@",respose);
         }];
         }
         */
    });
}
@end
