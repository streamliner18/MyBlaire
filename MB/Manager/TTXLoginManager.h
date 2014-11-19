//
//  TTXLoginManager.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBLRBaseViewController;
@interface TTXLoginManager : NSObject
SINGLETON_INTERFACE(TTXLoginManager)
- (void)sinaLoginWithViewController:(MBLRBaseViewController *)viewController;
- (void)qqLoginWithViewController:(MBLRBaseViewController *)viewController;
@end
