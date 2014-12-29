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
#import <SMPageControl.h>
#import "MBShareViewController.h"
#import "MLBlackTransition.h"

@interface MBGoodsInfoViewController ()<SwipeViewDataSource,SwipeViewDelegate,TTXActivityDelegate>
@property (nonatomic, strong) MBProductModel *model;
@property (nonatomic, strong) UIScrollView *backView;
@property (nonatomic, strong) SwipeView *goodsImages;
@property (nonatomic, strong) NSMutableArray *imageItems;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) SMPageControl *pageCotrol;
@property (nonatomic, strong) UIButton *addToCollecteButton;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic) BOOL shareViewShow;

@end

@implementation MBGoodsInfoViewController

- (instancetype)initWithModel:(MBProductModel *)model
{
    if (self = [super init]) {
        self.showCollecteCount = YES;
        self.model = model;
        if (model) {
            [MBSta staWithType:MBStaTypeClickGoods param:model.goodId];
        }
    }
    return self;
}

#pragma mark - properties

- (UIScrollView *)backView
{
    if (!_backView) {
        _backView = ({
            UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor clearColor];
            view;
        });
    }
    return _backView;
}

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
            view;
        });
    }
    return _colorView;
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

- (SMPageControl *)pageCotrol
{
    if (!_pageCotrol) {
        _pageCotrol = ({
            SMPageControl *control = [[SMPageControl alloc] initWithFrame:CGRectZero];
            [control setPageIndicatorImage:[UIImage imageNamed:@"PageControl_n"]];
            [control setCurrentPageIndicatorImage:[UIImage imageNamed:@"PageControl_s"]];
            control;
        });
    }
    return _pageCotrol;
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

#define kBackViewTopMargin (0)
#define kBackViewLeftMargin (0)

#define kSwipeViewTopMargin (0)
#define kSwipeViewBottomMargin (0)
#define kSwipeViewLeftMargin (4.5)

#define kTitleLabelTopMargin (10)
#define kTitleLabelHeight (30)

#define kDetailButtonRightMargin (10)
#define kDetailButtonTopMargin (50)
#define kDetailButtonWidth (60)
#define kDetailButtonHeight (30)

#define kPageControlBottomMargin (0)
#define kPageControlWidth (80)
#define kPageControlHeight (25)

#define kPriceWidth (100)
#define kPriceRightMargin (10)
#define kPriceHeight (20)
#define kPriceBottomMargin (10)

#define kAddCollecteLeftMargin (20)
#define kAddCollecteBottomMargin (20)
#define kAddCollecteWidth (36)
#define kAddCollecteHeight (30)

#define kShareRightMargin (15)
#define kShareBottomMargin (20)
#define kShareWidth (28)
#define kShareHeight (28)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.model.goodName stringByAppendingFormat:@" / ￥%@",self.model.currentPrice];
    if (kiOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self resetLeftBarButtonItem:LeftBarButtonItemTypeBack];

    self.backView.frame = CGRectMake(kBackViewLeftMargin, kBackViewTopMargin, self.view.width - kBackViewLeftMargin * 2, self.mbView.height - (kiOS7 ? 64 : 0) - 49);
    self.backView.backgroundColor = [UIColor colorWithHexString:@"#f1f2f6"];
    [self.mbView addSubview:self.backView];
    
    self.goodsImages.frame = CGRectMake(kSwipeViewLeftMargin, kSwipeViewTopMargin, self.backView.width - kSwipeViewLeftMargin * 2, 625 / 603.0 * (self.backView.width - kSwipeViewLeftMargin * 2));
    self.goodsImages.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:self.goodsImages];
    
    
    self.colorView.frame = CGRectMake(self.goodsImages.left, self.goodsImages.bottom, self.goodsImages.width, 89);
    [self.backView addSubview:self.colorView];
    
//    self.detailButton.frame = CGRectMake(self.backView.width - kDetailButtonRightMargin - kDetailButtonWidth, kDetailButtonTopMargin, kDetailButtonWidth, kDetailButtonHeight);
//    self.detailButton.userInteractionEnabled = NO;
//    [self.detailButton addTarget:self action:@selector(showDetailAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.backView addSubview:self.detailButton];
    
    self.pageCotrol.frame = CGRectMake((self.backView.width - kPageControlWidth) / 2.0, self.goodsImages.height + kPageControlBottomMargin, kPageControlWidth, kPageControlHeight);
    [self.backView addSubview:self.pageCotrol];
    
    
    self.addToCollecteButton.frame = CGRectMake(self.backView.width - kAddCollecteWidth - 25, self.pageCotrol.bottom + 15, kAddCollecteWidth, kAddCollecteHeight);
    [self.addToCollecteButton addTarget:self action:@selector(addCollecteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.addToCollecteButton];
    
    self.shareButton.frame = CGRectMake(self.backView.width - kShareRightMargin - kShareWidth, self.goodsImages.bottom - kShareHeight - 15, kShareWidth, kShareHeight);
    [self.shareButton setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"GoodsInfo" imageName:@"ProductShare"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareGoods) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.shareButton];
    
    self.backView.contentSize = CGSizeMake(self.backView.width, CGRectGetMaxY(self.addToCollecteButton.frame));
    
    [self resetCollecteState];
    
    [self showProgressHUD];
    
    @weakify(self);
    [MBApi getGoodsInfo:self.model.goodId completionHandle:^(MBApiError *error, NSDictionary *dic) {
        @strongify(self);
        [self hideProgressHUD];
        if (error.code == MBApiCodeSuccess && dic) {
            [self.model updateWithDic:dic];
            [self resetDatasource];
            [self addGoodsInfoView];
        }else{
            [self showMessageHUDWithMessage:error.message];
        }
    }];
}

- (void)addGoodsInfoView
{
    MBGoodsDetailInfoView *view = [[MBGoodsDetailInfoView alloc] initWithFrame:CGRectMake(4.5, CGRectGetMaxY(self.addToCollecteButton.frame)+18+4.5, self.backView.width - 9, 280) model:self.model];
    [self.backView addSubview:view];
    self.backView.contentSize = CGSizeMake(self.backView.width, view.bottom);
}

- (void)resetCollecteState
{
    if (self.model.isCollect) {
        [self.addToCollecteButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"GoodsInfo" imageName:@"ProductLikeClicked"] forState:UIControlStateNormal];
        [self.addToCollecteButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"GoodsInfo" imageName:@"ProductLike"] forState:UIControlStateHighlighted];
    }else{
        [self.addToCollecteButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"GoodsInfo" imageName:@"ProductLike"] forState:UIControlStateNormal];
        [self.addToCollecteButton setBackgroundImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"GoodsInfo" imageName:@"ProductLikeClicked"] forState:UIControlStateHighlighted];
    }
    if (self.showCollecteCount) {
        if (self.model.collectCount) {
            [self.addToCollecteButton setTitle:[NSString stringWithFormat:@"%d",self.model.collectCount] forState:UIControlStateNormal];
        }else{
            [self.addToCollecteButton setTitle:nil forState:UIControlStateNormal];
        }
        if (self.model.isCollect) {
            [self.addToCollecteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [self.addToCollecteButton setTitleColor:[UIColor colorWithHexString:@"#434a54"] forState:UIControlStateNormal];
        }
    }
}

- (void)resetDatasource
{
    if (self.model) {
        [self.imageItems removeAllObjects];
        if (self.model.bigPictures.count) {
            [self.imageItems addObjectsFromArray:self.model.bigPictures];
        }else{
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
        imageView.backgroundColor = V_COLOR(67, 74, 84, 1.0);
        imageView.tag = 1;
        [view addSubview:imageView];
    } else {
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    if (index < self.imageItems.count) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageItems[index]]];
        DLog(@"%@",[MBApi serverImageURLWithImageName:self.imageItems[index]]);
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
    
}

- (void)addCollecteAction
{
    [MBSta staWithType:MBStaTypeClickCollecte param:self.model.goodId];
    [MBApi collecteGoods:self.model.goodId collecteState:self.model.isCollect?@"1":@"0" completionHandle:^(MBApiError *error) {
        if (error.code == MBApiCodeSuccess) {
            if (self.model.isCollect) {
                self.model.collectCount = MAX(0, self.model.collectCount - 1);
                [self showMessageHUDWithMessage:@"取消收藏"];
            }else{
                self.model.collectCount = MAX(0, self.model.collectCount + 1);
                [self showMessageHUDWithMessage:@"已收藏到心愿单"];
            }
            self.model.isCollect = !self.model.isCollect;
            [self resetCollecteState];
        }else{
            [self showMessageHUDWithMessage:error.message];
        }
    }];
}

- (void)shareGoods
{
    [MBSta staWithType:MBStaTypeClickShare param:self.model.goodId];
    MBShareViewController *viewController = [[MBShareViewController alloc] initWithModel:self.model];
    [self.navigationController enabledMLBlackTransition:NO];
    @weakify(viewController);
    viewController.hideBlock = ^(){
        @strongify(viewController);
        [self.navigationController enabledMLBlackTransition:YES];
        self.tabBarController.tabBar.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            viewController.view.alpha = 0;
        }completion:^(BOOL finished) {
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }];
    };
    [self.view addSubview:viewController.view];
    self.tabBarController.tabBar.hidden = YES;
    [self addChildViewController:viewController];
    
    viewController.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        viewController.view.alpha = 1;
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController enabledMLBlackTransition:YES];
    [super viewDidDisappear:animated];
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
