//
//  MBConfig.h
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUmengAppkey                    @"5211818556240bc9ee01db2f"

#define kQQAppKey                       @"222222"

#define kIMWechatAppKey                 @"wxd930ea5d5a258f4f"
#define kIMWechatAppSecret              @"db426a9829e4b49a0dcac7b4162da6b6"
#define kIMWechatAppRedirectUrl         @"http://www.umeng.com/social"

#define kSnsSinaWeiboAppKey             @"3887800429"
#define kSnsSinaWeiboAppSecret          @"83e8511087b9476d63d4e1c542dcb847"
#define kSnsSinaWeiboRedirectUrl        @"http://www.meituliaoliao.com"

#define MYDEBUG (1)

#define MBURLBASE                       (MYDEBUG ? @"http://182.92.243.125:8080" : @"http://192.168.100.102:8080")


//需要展示引导页的版本
extern NSString* TTX_ShowGuide_AppVersion(void);
//是否第一次运行当前版本
extern BOOL TTX_AppVersion_Is_FirstLoad(NSString *version);

extern NSString* MB_ShouldHideLaunchView(void);
