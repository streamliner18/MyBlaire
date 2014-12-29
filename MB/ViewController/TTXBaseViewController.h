//
//  Created by Tongtong Xu on 14-11-10.
//  Copyright (c) 2014年 Beijing Luxi Information Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationProtocol.h"

typedef NS_ENUM(NSUInteger, LeftBarButtonItemType) {
    LeftBarButtonItemTypeBack,
};

@interface TTXBaseViewController : UIViewController <UINavigationProtocol>
@property (nonatomic,strong) UIView *mbView;
+ (instancetype)loadFromXib;


- (void)resetLeftBarButtonItem:(LeftBarButtonItemType)type;
- (void)backItemAction:(UIBarButtonItem *)sender;
#pragma mark - UI Util Elements

- (void)showProgressHUD;
- (void)hideProgressHUD;
- (void)showSpriteProgressHUD;

- (void)showAlertTitle:(NSString *)title message:(NSString *)message;
- (void)showError:(NSError *)error message:(NSString *)message;
- (void)showMessageHUDWithMessage:(NSString *)message;
@end
