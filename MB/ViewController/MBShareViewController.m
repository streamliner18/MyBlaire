//
//  MBShareViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/12/3.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBShareViewController.h"
#import "MBProductModel.h"
#import "MLBlackTransition.h"

#import <SDWebImageDownloader.h>
#import <UMSocial.h>

typedef void(^MBShareContentBlock)(UIImage *shareImage,NSString *shareText);

@interface MBShareViewController ()<UMSocialUIDelegate>
@property (nonatomic, strong) MBProductModel *model;
@end

@implementation MBShareViewController

- (instancetype)initWithModel:(MBProductModel *)model
{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

#define kLineLeftMargin (49)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setDisableMLBlackTransition:YES];
    
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];
    self.title = @"分享";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#686e76"];
    UIButton *close = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.width - 28 - 10, 10, 28, 28);
        [button setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Share" imageName:@"Close"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popToLastView) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.mbView addSubview:close];
    
    UIButton *sina = [[UIButton alloc] initWithFrame:CGRectMake(0, 58, self.view.width, 90)];
    [sina addTarget:self action:@selector(shareToSina) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:sina];
    UIImageView *sinaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(71, 29, 32, 32)];
    sinaImageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Share" imageName:@"ShareWeibo"];
    [sina addSubview:sinaImageView];
    UILabel *sinaTitle = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sinaImageView.right + 12, sinaImageView.top+6, 120, 20)];
        label.text = @"分享到微博";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label;
    });
    [sina addSubview:sinaTitle];
    
    
    UIView *sLine = [[UIView alloc] initWithFrame:CGRectMake(kLineLeftMargin, sina.bottom, self.view.width - kLineLeftMargin * 2, 0.5)];
    sLine.backgroundColor = [UIColor whiteColor];
    [self.mbView addSubview:sLine];
    
    UIButton *wxf = [[UIButton alloc] initWithFrame:CGRectMake(0, sina.bottom+1, self.view.width, 90)];
    [wxf addTarget:self action:@selector(shareToWx) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:wxf];
    UIImageView *wxfImageView = [[UIImageView alloc] initWithFrame:CGRectMake(71, 29, 32, 32)];
    wxfImageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Share" imageName:@"ShareWechat"];
    [wxf addSubview:wxfImageView];
    UILabel *wxfTitle = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(wxfImageView.right + 12, wxfImageView.top+6, 140, 20)];
        label.text = @"分享给微信好友";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label;
    });
    [wxf addSubview:wxfTitle];
    
    
    
    
    
    UIView *wLine = [[UIView alloc] initWithFrame:CGRectMake(kLineLeftMargin, wxf.bottom, self.view.width - kLineLeftMargin * 2, 0.5)];
    wLine.backgroundColor = [UIColor whiteColor];
    [self.mbView addSubview:wLine];
    
    UIButton *wxp = [[UIButton alloc] initWithFrame:CGRectMake(0, wxf.bottom+1, self.view.width, 90)];
    [wxp addTarget:self action:@selector(shareToWXF) forControlEvents:UIControlEventTouchUpInside];
    [self.mbView addSubview:wxp];
    UIImageView *wxpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(71, 29, 32, 32)];
    wxpImageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Share" imageName:@"ShareMoments"];
    [wxp addSubview:wxpImageView];
    UILabel *wxpTitle = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(wxpImageView.right + 12, wxpImageView.top+6, 160, 20)];
        label.text = @"分享到微信朋友圈";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label;
    });
    [wxp addSubview:wxpTitle];

    UIView *wpLine = [[UIView alloc] initWithFrame:CGRectMake(kLineLeftMargin, wxp.bottom, self.view.width - kLineLeftMargin * 2, 0.5)];
    wpLine.backgroundColor = [UIColor whiteColor];
    [self.mbView addSubview:wpLine];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)shareToSina
{
    [self prepareImage:^(UIImage *shareImage, NSString *shareText) {
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.snsClickHandler([[UIApplication sharedApplication] keyWindow].rootViewController,[UMSocialControllerService defaultControllerService],YES);
    }];
    
}

- (void)shareToWx
{
    [self prepareImage:^(UIImage *shareImage, NSString *shareText) {
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        snsPlatform.snsClickHandler([[UIApplication sharedApplication] keyWindow].rootViewController,[UMSocialControllerService defaultControllerService],YES);
    }];
}

- (void)prepareImage:(MBShareContentBlock)block
{
    if (self.model) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.model.collecteViewNeedShowImageURL] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image) {
                block(image,@"我在MyBlaire蜜包上发现的美包");
            }else{
                [self showError:error message:error.localizedDescription];
            }
        }];
    }else{
        block(nil,@"我邀请你下载MyBlaire蜜包,http://www.baidu.com");
    }
}

- (void)shareToWXF
{
    [self prepareImage:^(UIImage *shareImage, NSString *shareText) {
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline];
        snsPlatform.snsClickHandler([[UIApplication sharedApplication] keyWindow].rootViewController,[UMSocialControllerService defaultControllerService],YES);
    }];
}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    if (self.model) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
}

- (void)popToLastView
{
    if (self.hideBlock) {
        self.hideBlock();
    }
}

- (void)backItemAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
