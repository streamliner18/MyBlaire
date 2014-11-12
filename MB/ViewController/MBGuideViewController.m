//
//  GuideViewController.m
//  MB
//
//  Created by Tongtong Xu on 14/11/11.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBGuideViewController.h"

@interface MBGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation MBGuideViewController

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _titleLabel;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectZero];
            view.pagingEnabled = YES;
            view.showsHorizontalScrollIndicator = NO;
            view.delegate = self;
            view;
        });
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectZero];
            control;
        });
    }
    return _pageControl;
}

- (UIButton *)registButton
{
    if (!_registButton) {
        _registButton = [UIButton registButton];
    }
    return _registButton;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton loginButton];
    }
    return _loginButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(self.view.width * 4, self.view.height);
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    
    self.pageControl.frame = CGRectMake(0, 0, self.view.width, 30);
    self.pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 150);
    self.pageControl.numberOfPages = 4;
    
    self.titleLabel.frame = CGRectMake(0, 100, self.view.width, 40);
    self.titleLabel.text = @"Welcome to 蜜包";
    
    self.registButton.center = CGPointMake(100, self.view.height - 100);
    [self.registButton addTarget:self action:@selector(doRegist:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.center = CGPointMake(200, self.view.height - 100);
    [self.loginButton addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.registButton];
    [self.view addSubview:self.loginButton];
}

- (void)doRegist:(UIButton *)sender
{
    if (_registActionBlock) {
        _registActionBlock();
    }else{
        [self showMessageHUDWithMessage:@"注册"];
    }
}

- (void)doLogin:(UIButton *)sender
{
    if (_loginActionBlock) {
        _loginActionBlock();
    }else{
        [self showMessageHUDWithMessage:@"登录"];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / 320;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
