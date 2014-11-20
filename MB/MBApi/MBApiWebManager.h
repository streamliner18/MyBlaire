//
//  MBApiWebManager.h
//  MB
//
//  Created by Tongtong Xu on 14/11/17.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <AFHTTPRequestOperationManager.h>

@interface MBApiWebManager : AFHTTPRequestOperationManager

/**
 *  header包含token
 */

+ (instancetype)shareWithToken;

/**
 *  header不包含token
 */

+ (instancetype)shareWithoutToken;

@end
