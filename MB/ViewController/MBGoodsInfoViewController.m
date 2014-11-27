//
//  MBGoodsInfoViewController.m
//  MB
//
//  Created by xt-work on 14/11/20.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBGoodsInfoViewController.h"
#import <SwipeView.h>
#import "MBProductModel.h"
#import "MBGoodsDetailInfoView.h"
#import "TTXActivity.h"

@interface MBGoodsInfoViewController ()<SwipeViewDataSource,SwipeViewDelegate,TTXActivityDelegate>
@property (nonatomic, strong) MBProductModel *model;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *goodsTitlelabel;
@property (nonatomic, strong) SwipeView *goodsImages;
@property (nonatomic, strong) NSMutableArray *imageItems;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIPageControl *pageCotrol;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addToCollecteButton;
@property (nonatomic, strong) UIButton *shareButton;
@end

@implementation MBGoodsInfoViewController

- (instancetype)initWithModel:(MBProductModel *)model
{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

#pragma mark - properties

- (UIView *)backView
{
    if (!_backView) {
        _backView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor lightGrayColor];
            view;
        });
    }
    return _backView;
}

- (UILabel *)goodsTitlelabel
{
    if (!_goodsTitlelabel) {
        _goodsTitlelabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _goodsTitlelabel;
}

- (SwipeView *)goodsImages
{
    if (!_goodsImages) {
        _goodsImages = ({
            SwipeView *view = [[SwipeView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate = self;
            view.pagingEnabled = YES;
            view;
        });
    }
    return _goodsImages;
}

- (UIButton *)detailButton
{
    if (!_detailButton) {
        _detailButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"详细" forState:UIControlStateNormal];
            button;
        });
    }
    return _detailButton;
}

- (UIPageControl *)pageCotrol
{
    if (!_pageCotrol) {
        _pageCotrol = ({
            UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectZero];
            control;
        });
    }
    return _pageCotrol;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentRight;
            label;
        });
    }
    return _priceLabel;
}

- (UIButton *)addToCollecteButton
{
    if (!_addToCollecteButton) {
        _addToCollecteButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button;
        });
    }
    return _addToCollecteButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor yellowColor];
            [button setTitle:@"分享" forState:UIControlStateNormal];
            button;
        });
    }
    return _shareButton;
}

- (NSMutableArray *)imageItems
{
    if (!_imageItems) {
        _imageItems = @[].mutableCopy;
    }
    return _imageItems;
}

#define kBackViewTopMargin (10)
#define kBackViewLeftMargin (10)

#define kSwipeViewTopMargin (50)
#define kSwipeViewBottomMargin (10)
#define kSwipeViewLeftMargin (10)

#define kTitleLabelTopMargin (10)
#define kTitleLabelHeight (30)

#define kDetailButtonRightMargin (10)
#define kDetailButtonTopMargin (50)
#define kDetailButtonWidth (60)
#define kDetailButtonHeight (30)

#define kPageControlBottomMargin (30)
#define kPageControlWidth (80)
#define kPageControlHeight (30)

#define kPriceWidth (100)
#define kPriceRightMargin (10)
#define kPriceHeight (20)
#define kPriceBottomMargin (10)

#define kAddCollecteLeftMargin (20)
#define kAddCollecteBottomMargin (20)
#define kAddCollecteWidth (50)
#define kAddCollecteHeight (30)

#define kShareRightMargin (20)
#define kShareBottomMargin (20)
#define kShareWidth (50)
#define kShareHeight (30)

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backView.frame = CGRectMake(kBackViewLeftMargin, 44 + (iOS7 ? 20 : 0) + kBackViewTopMargin, self.view.width - kBackViewLeftMargin * 2, 400);
    [self.view addSubview:self.backView];
    
    self.goodsImages.frame = CGRectMake(kSwipeViewLeftMargin, kSwipeViewTopMargin, self.backView.width - kSwipeViewLeftMargin * 2, self.backView.height - kSwipeViewTopMargin - kSwipeViewBottomMargin);
    self.goodsImages.backgroundColor = [UIColor orangeColor];
    [self.backView addSubview:self.goodsImages];
    
    self.goodsTitlelabel.frame = CGRectMake(0, kTitleLabelTopMargin, self.backView.width, kTitleLabelHeight);
    self.goodsTitlelabel.text = self.model.goodName;
    [self.backView addSubview:self.goodsTitlelabel];
    
    self.detailButton.frame = CGRectMake(self.backView.width - kDetailButtonRightMargin - kDetailButtonWidth, kDetailButtonTopMargin, kDetailButtonWidth, kDetailButtonHeight);
    self.detailButton.userInteractionEnabled = NO;
    [self.detailButton addTarget:self action:@selector(showDetailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.detailButton];
    
    self.pageCotrol.frame = CGRectMake((self.backView.width - kPageControlWidth) / 2.0, self.backView.height - kPageControlBottomMargin - kPageControlHeight, kPageControlWidth, kPageControlHeight);
    [self.backView addSubview:self.pageCotrol];
    
    self.priceLabel.frame = CGRectMake(self.backView.width - kPriceRightMargin - kPriceWidth, self.backView.height - kPriceBottomMargin - kPriceHeight, kPriceWidth, kPriceHeight);
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",self.model.currentPrice];
    [self.backView addSubview:self.priceLabel];

    self.addToCollecteButton.frame = CGRectMake(kAddCollecteLeftMargin, self.view.height - kAddCollecteHeight - kAddCollecteBottomMargin - (iOS7?44:0), kAddCollecteWidth, kAddCollecteHeight);
    [self.addToCollecteButton addTarget:self action:@selector(addCollecteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addToCollecteButton];
    
    self.shareButton.frame = CGRectMake(self.view.width - kShareRightMargin - kShareWidth, self.view.height - kShareBottomMargin - kShareHeight - (iOS7?44:0), kShareWidth, kShareRightMargin);
    [self.shareButton addTarget:self action:@selector(shareGoods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareButton];
    
    [self resetCollecteState];
    
    [self showProgressHUD];
    
    [MBApi getGoodsInfo:self.model.goodId completionHandle:^(MBApiError *error, NSDictionary *dic) {
        [self hideProgressHUD];
        if (error.code == MBApiCodeSuccess && dic) {
            [self.model updateWithDic:dic];
            [self resetDatasource];
        }else{
            [self showMessageHUDWithMessage:error.message];
        }
    }];
}

- (void)resetCollecteState
{
    if (self.model.isCollect) {
        [self.addToCollecteButton setImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"collected_n"] forState:UIControlStateNormal];
        [self.addToCollecteButton setImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"collecte_n"] forState:UIControlStateHighlighted];
    }else{
        [self.addToCollecteButton setImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"collecte_n"] forState:UIControlStateNormal];
        [self.addToCollecteButton setImage:[UIImage bt_imageWithBundleName:@"Source" imageName:@"collected_n"] forState:UIControlStateHighlighted];
    }
}

- (void)resetDatasource
{
    if (self.model) {
        [self.imageItems removeAllObjects];
        if (self.model.bigPctureUrl) {
            [self.imageItems addObject:self.model.bigPctureUrl];
        }
        if (self.model.bigPctureUrl2) {
            [self.imageItems addObject:self.model.bigPctureUrl2];
        }
        if (self.model.bigPctureUrl3) {
            [self.imageItems addObject:self.model.bigPctureUrl3];
        }
    }
    [self.goodsImages reloadData];
    self.detailButton.userInteractionEnabled = YES;
    self.pageCotrol.numberOfPages = self.imageItems.count;
    self.pageCotrol.currentPage = 0;
}

#pragma mark - swipeview datasource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.imageItems count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:self.goodsImages.bounds];
        view.backgroundColor = [UIColor clearColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.backgroundColor = [UIColor yellowColor];
        imageView.tag = 1;
        [view addSubview:imageView];
    } else {
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    if (index < self.imageItems.count) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:[MBApi serverImageURLWithImageName:self.imageItems[index]]]];
    }
    
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.goodsImages.bounds.size;
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    self.pageCotrol.currentPage = swipeView.currentPage;
}

- (void)showDetailAction
{
    MBGoodsDetailInfoView *view = [[MBGoodsDetailInfoView alloc] initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds] model:self.model];
    view.tintColor = [UIColor whiteColor];
    view.blurRadius = 50;
    view.dynamic = NO;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}

- (void)addCollecteAction
{
    [MBApi collecteGoods:self.model.goodId completionHandle:^(MBApiError *error) {
        [self showMessageHUDWithMessage:error.message];
    }];
}

- (void)shareGoods
{
    NSArray *shareButtonTitleArray = @[@"新浪微博",@"微信",@"微信朋友圈"];
    NSArray *shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23"];

    TTXActivity *activity = [[TTXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [activity showInView:self.view];

}

- (void)didClickOnImageIndex:(NSInteger)imageIndex
{
    DLog(@"%d",imageIndex);
}

+ (UIColor *)viewBackgroundColor
{
    return [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
