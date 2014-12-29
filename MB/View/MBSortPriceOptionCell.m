//
//  MBSortPriceOptionCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/28.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortPriceOptionCell.h"
#import "MBSortModel.h"
#import "MBSorter.h"

@interface MBSortPriceOptionCell ()
@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *leftImageView;
@property (nonatomic, strong) UIView *rightImageView;
@property (nonatomic, strong) UILabel *zero;
@property (nonatomic, strong) UILabel *onet;
@property (nonatomic, strong) UILabel *fivet;
@property (nonatomic, strong) UILabel *tent;
@property (nonatomic, strong) UIView *sepView;
@end

@implementation MBSortPriceOptionCell

- (UIView *)sepView
{
    if (!_sepView) {
        _sepView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            view;
        });
    }
    return _sepView;
}
- (UIView *)touchView
{
    if (!_touchView) {
        _touchView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor clearColor];
            view;
        });
    }
    return _touchView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _lineView;
}

- (UIView *)redView
{
    if (!_redView) {
        _redView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor redColor];
            view;
        });
    }
    return _redView;
}

- (UILabel *)zero
{
    if (!_zero) {
        _zero = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"￥0";
            label.font = [UIFont italicSystemFontOfSize:12];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _zero;
}

- (UILabel *)onet
{
    if (!_onet) {
        _onet = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"￥1000";
            label.font = [UIFont italicSystemFontOfSize:12];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _onet;
}

- (UILabel *)fivet
{
    if (!_fivet) {
        _fivet = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"￥5000";
            label.font = [UIFont italicSystemFontOfSize:12];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _fivet;
}

- (UILabel *)tent
{
    if (!_tent) {
        _tent = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"￥10000";
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont italicSystemFontOfSize:12];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _tent;
}

- (void)buildSubviews
{
    [self addSubview:self.touchView];
    [self.touchView addSubview:self.onet];
    [self.touchView addSubview:self.zero];
    [self.touchView addSubview:self.fivet];
    [self.touchView addSubview:self.tent];
    [self.touchView addSubview:self.lineView];
    self.leftImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.leftImageView.backgroundColor = [UIColor whiteColor];
    self.leftImageView.clipsToBounds = YES;
    self.leftImageView.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
    self.leftImageView.layer.borderWidth = 1;
    self.leftImageView.layer.cornerRadius = 5;
    [self.redView addSubview:self.leftImageView];
    self.rightImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.rightImageView.backgroundColor = [UIColor whiteColor];
    self.rightImageView.clipsToBounds = YES;
    self.rightImageView.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
    self.rightImageView.layer.borderWidth = 1;
    self.rightImageView.layer.cornerRadius = 5;
    [self.redView addSubview:self.rightImageView];
    [self.touchView addSubview:self.redView];
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self addSubview:self.sepView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.touchView.frame = CGRectMake(27.5, 0, self.width - 55, self.height);
    
    self.zero.frame = CGRectMake(0, 18, 24, 12);
    self.onet.frame = CGRectMake(self.touchView.width / 4.0 - 15, 18, 50, 12);
    self.fivet.frame = CGRectMake(self.touchView.width / 4.0 * 2 - 15, 18, 50, 12);
    self.tent.frame = CGRectMake(self.touchView.width / 4.0 * 3, 18, 55, 12);

    self.lineView.frame = CGRectMake(0, 40, self.touchView.width, 4);
    self.lineView.layer.cornerRadius = 2;
    self.lineView.layer.borderWidth = 0.5;
    self.lineView.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
    
    CGRect rect = CGRectZero;
    switch ([MBSorter shared].currentPriceSortModel.type) {
        case MBGoodsConditionMoreThan10000:
            rect = CGRectMake(self.lineView.width / 4.0 * 3+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
            break;
        case MBGoodsConditionBetween5000And10000:
            rect = CGRectMake(self.lineView.width / 4.0 * 2+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
            break;
        case MBGoodsConditionBetween1000And5000:
            rect = CGRectMake(self.lineView.width / 4.0+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
            break;
        case MBGoodsConditionLessThan1000:
            rect = CGRectMake( 0+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
            break;
        default:
            break;
    }
    self.redView.frame = rect;
    self.leftImageView.frame = CGRectMake(-1, 0, 10, 10);
    self.rightImageView.frame = CGRectMake(self.redView.width-5, 0, 10, 10);
    self.leftImageView.center = CGPointMake(self.leftImageView.center.x, self.redView.height / 2.0);
    self.rightImageView.center = CGPointMake(self.rightImageView.center.x, self.redView.height / 2.0);
    
    self.sepView.frame = CGRectMake(6, self.height - 0.5, self.width - 12, 0.5);
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    sender.enabled = NO;
    CGRect rect = CGRectZero;
    CGFloat x = [sender locationInView:sender.view].x;
    if (x <= sender.view.width / 4.0) {
        [MBSorter shared].currentPriceSortModel.type = MBGoodsConditionLessThan1000;
        rect = CGRectMake( 0+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
    }else if (x >= 3 * sender.view.width / 4.0) {
        [MBSorter shared].currentPriceSortModel.type = MBGoodsConditionMoreThan10000;
        rect = CGRectMake(self.lineView.width / 4.0 * 3+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
    }else if (x >= 2 * sender.view.width / 4.0){
        [MBSorter shared].currentPriceSortModel.type = MBGoodsConditionBetween5000And10000;
        rect = CGRectMake(self.lineView.width / 4.0 * 2+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
    }else{
        [MBSorter shared].currentPriceSortModel.type = MBGoodsConditionBetween1000And5000;
        rect = CGRectMake(self.lineView.width / 4.0+self.lineView.left, 0+self.lineView.top, self.lineView.width / 4.0, 4);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.redView.frame = rect;
    }completion:^(BOOL finished) {
        sender.enabled = YES;
    }];
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 64.5;
}

@end
