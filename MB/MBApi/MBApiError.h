//
//  MBApiError.h
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBApiCode) {
    MBApiCodeNetworkError = -1,
    MBApiCodeSuccess = 0,
    MBApiCodeRegisterFaildWithUserNameRepeat = 1,
    MBApiCodeRegisterFaildWithEmailError = 1000,
};

@interface MBApiError : NSObject
@property (nonatomic) MBApiCode code;
@property (nonatomic) NSString *message;

+ (instancetype)shareWithCode:(MBApiCode)code message:(NSString *)message;

+ (instancetype)shareNetworkError;

+ (instancetype)shareWithDictionary:(NSDictionary *)dic;
@end
