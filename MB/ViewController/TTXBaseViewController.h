//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTXBaseViewController : UIViewController

#pragma mark - UI Util Elements

- (void)showProgressHUD;
- (void)hideProgressHUD;

- (void)showAlertTitle:(NSString *)title message:(NSString *)message;
- (void)showError:(NSError *)error message:(NSString *)message;
- (void)showMessageHUDWithMessage:(NSString *)message;

@end
