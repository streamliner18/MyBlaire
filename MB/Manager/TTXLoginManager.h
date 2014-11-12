//
//  TTXLoginManager.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTXLoginManager : NSObject
SINGLETON_INTERFACE(TTXLoginManager)
- (void)sinaLoginWithViewController:(UIViewController *)viewController;
- (void)qqLoginWithViewController:(UIViewController *)viewController;
@end
