//
//  UINavigationProtocol.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UINavigationProtocol <NSObject>

+ (NSString *)navigationItemTitle;
+ (NSString *)navigationItemDisappearTitle;
+ (BOOL)automaticallyAdjustsScrollViewInsets;

@end
