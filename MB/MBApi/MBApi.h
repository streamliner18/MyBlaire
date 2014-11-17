//
//  MBApi.h
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBLoginType) {
    MBLoginTypeNormal,
    MBLoginTypeQQ,
    MBLoginTypeSina,
};

typedef void(^MBApiRegisterBlock)(MBApiError *error);
typedef void(^MBApiLoginBlock)(MBApiError *error);
typedef void(^MBApiKeyWordBlock)(MBApiError *error, NSArray *keyArray);

@interface MBApi : NSObject

+ (void)registerNewUserWithUserName:(NSString *)userName password:(NSString *)password email:(NSString *)mail handle:(MBApiRegisterBlock)block;

+ (void)loginWithType:(MBLoginType)type userName:(NSString *)userName password:(NSString *)password token:(NSString *)token handle:(MBApiLoginBlock)block;

+ (void)getKeyWord;

@end
