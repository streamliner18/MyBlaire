//
//  MBAboutViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBAboutViewController.h"
#import "MBShareViewController.h"
#import "MBFeedBackViewController.h"
#import "MBHomePageViewController.h"

@interface MBAboutViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MBAboutViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:nil tag:0];
        [self.tabBarItem setFinishedSelectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_4_selected"] withFinishedUnselectedImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"tab_4_normal"]];
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mbView.width, self.mbView.height - 49 - (kiOS7?64:0))];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#f1f2f6"];
    [self.mbView addSubview:self.scrollView];
    
    
    NSString *us = @"我们是";
    CGSize size = BT_MULTILINE_TEXTSIZE(us, [UIFont systemFontOfSize:18], CGSizeMake(self.view.width, MAXFLOAT), NSLineBreakByWordWrapping);
    UILabel *uslabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10, self.view.width, size.height)];
    uslabel.text = us;
    uslabel.textColor = [UIColor colorWithHexString:@"#949fab"];
    uslabel.numberOfLines = 0;
    uslabel.lineBreakMode = NSLineBreakByWordWrapping;
    uslabel.textAlignment = NSTextAlignmentCenter;
    uslabel.font = [UIFont systemFontOfSize:18];
    [self.scrollView addSubview:uslabel];
    
    UILabel *dgLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, uslabel.bottom + 100, self.view.width, 22)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor colorWithHexString:@"#434a54"];
        label.text = @"如 何 代 购";
        label;
    });
    [self.scrollView addSubview:dgLabel];
    
    
    NSString *dg = @"我们是";
    size = BT_MULTILINE_TEXTSIZE(dg, [UIFont systemFontOfSize:18], CGSizeMake(self.view.width, MAXFLOAT), NSLineBreakByWordWrapping);
    UILabel *dgContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, dgLabel.bottom + 10, self.view.width, size.height)];
    dgContentLabel.text = dg;
    dgContentLabel.numberOfLines = 0;
    dgContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    dgContentLabel.textAlignment = NSTextAlignmentCenter;
    dgContentLabel.font = [UIFont systemFontOfSize:18];
    dgContentLabel.textColor = [UIColor colorWithHexString:@"#949fab"];
    [self.scrollView addSubview:dgContentLabel];
    
    UIButton *feedback = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(51, self.scrollView.height - 41 - 28, 96, 28);
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"AboutFeedback"] forState:UIControlStateNormal];
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"AboutFeedbackPressed"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(feedBack) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.scrollView addSubview:feedback];
    
    UIButton *share = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.mbView.width - 61 - 61, self.scrollView.height - 41 - 28, 61, 28);
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"AboutShare"] forState:UIControlStateNormal];
        [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"AboutSharePressed"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.scrollView addSubview:share];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.scrollView.height + 15, 126, 43);
    button.center = CGPointMake(self.scrollView.width / 2.0, button.center.y);
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"LogoutButton"] forState:UIControlStateNormal];
    [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"About" imageName:@"LogoutButtonClicked"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, button.bottom+20);
}
- (void)loginOut
{
    [MB_Model clear];
    self.navigationController.tabBarController.selectedIndex = 0;
    MBHomePageViewController *vc = [[[[self.navigationController.tabBarController viewControllers] firstObject] viewControllers] firstObject];
    [vc reloadDateAfterLoginOut];
}

- (void)feedBack
{
    MBFeedBackViewController *feed = [[MBFeedBackViewController alloc] init];
    [self.navigationController pushViewController:feed animated:YES];
}

- (void)shareAction
{
    MBShareViewController *share = [[MBShareViewController alloc] init];
    [self.navigationController pushViewController:share animated:YES];
}

#pragma mark - UINavigationProtocol

+ (NSString *)navigationItemTitle
{
    return @"关 于 我 们";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
