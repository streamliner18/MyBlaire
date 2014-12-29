//
//  MBConfig.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUmengAppkey                    @"549e26c2fd98c5294a001bda"

#define kQQAppKey                       @"222222"

#define kIMWechatAppKey                 @"wxd930ea5d5a258f4f"
#define kIMWechatAppSecret              @"db426a9829e4b49a0dcac7b4162da6b6"
#define kIMWechatAppRedirectUrl         @"http://www.umeng.com/social"

#define kSnsSinaWeiboAppKey             @"4101500684"
#define kSnsSinaWeiboAppSecret          @"fcb4032aeb1acaf967cfec5e6dcad0d7"
#define kSnsSinaWeiboRedirectUrl        @"http://sns.whalecloud.com/sina2/callback"

#define MYDEBUG (1)

#define MBURLBASE                       (MYDEBUG ? @"http://182.92.243.125:8080" : @"http://192.168.1.111:8080")

#define SORTVIETYPE (0)

//需要展示引导页的版本
extern NSString* TTX_ShowGuide_AppVersion(void);
//是否第一次运行当前版本
extern BOOL TTX_AppVersion_Is_FirstLoad(NSString *version);

extern NSString* MB_ShouldHideLaunchView(void);

#define kGoodsListViewBackgroundColor V_COLOR(244, 246, 245, 1.0)
#define kGoodsNameTextColor V_COLOR(67, 74, 84, 1.0)
#define kGoodsPriceTextColor V_COLOR(148, 159, 171, 1.0)

#define kFeedBackNameFieldBackgroundColor V_COLOR(200, 215, 212, 1.0)
#define kFeedBackSendButtonTextColor V_COLOR(175, 163, 118, 1)

#define kShareViewBackgroundColor V_COLOR(104, 110, 118, 1.0)

#define kSearchKeyBackgroundColor V_COLOR(120, 121, 123, 1.0)

#define kHomePageViewStarSameNameColor V_COLOR(130, 133, 139, 1.0)
#define kHomePageViewStarSamePriceColor V_COLOR(67, 74, 84, 1.0)
