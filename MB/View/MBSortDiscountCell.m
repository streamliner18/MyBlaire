//
//  MBSortDiscountCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/28.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortDiscountCell.h"
#import "MBSorter.h"

@interface MBSortDiscountCell ()
@property (nonatomic, strong) UILabel *d9;
@property (nonatomic, strong) UILabel *d8;
@property (nonatomic, strong) UILabel *d7;
@property (nonatomic, strong) UILabel *d0;
@property (nonatomic, strong) UIButton *b9;
@property (nonatomic, strong) UIButton *b8;
@property (nonatomic, strong) UIButton *b7;
@property (nonatomic, strong) UIButton *b0;
@property (nonatomic, strong) UIView *sepView;
@end

@implementation MBSortDiscountCell

- (UILabel *)d9{
    if (!_d9) {
        _d9 = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"9 折";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _d9;
}
- (UILabel *)d8{
    if (!_d8) {
        _d8 = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"8 折";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _d8;
}
- (UILabel *)d7{
    if (!_d7) {
        _d7 = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"7 折";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _d7;
}
- (UILabel *)d0{
    if (!_d0) {
        _d0 = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @" 更低折扣";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#7a8799"];
            label;
        });
    }
    return _d0;
}

- (UIButton *)b9
{
    if (!_b9) {
        _b9 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButton"] forState:UIControlStateNormal];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButtonClicked"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _b9;
}
- (UIButton *)b8
{
    if (!_b8) {
        _b8 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButton"] forState:UIControlStateNormal];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButtonClicked"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _b8;
}
- (UIButton *)b7
{
    if (!_b7) {
        _b7 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButton"] forState:UIControlStateNormal];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButtonClicked"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _b7;
}
- (UIButton *)b0
{
    if (!_b0) {
        _b0 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButton"] forState:UIControlStateNormal];
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"RadioButtonClicked"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _b0;
}
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
- (void)buildSubviews
{
    [self addSubview:self.d9];
    
    [self addSubview:self.d8];
    
    [self addSubview:self.d7];
    
    [self addSubview:self.d0];
    
    [self addSubview:self.b9];
    
    [self addSubview:self.b8];
    
    [self addSubview:self.b7];
    
    [self addSubview:self.b0];
    
    [self addSubview:self.sepView];
}

#define kDeltaHeight (17)

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.d9.frame = CGRectMake(30, 0, 40, self.height / 4);
    
    self.d8.frame = CGRectMake(30, (self.height - kDeltaHeight) / 4, 40, self.height / 4);
    
    self.d7.frame = CGRectMake(30, (self.height - kDeltaHeight) / 4 * 2, 40, self.height / 4);
    
    self.d0.frame = CGRectMake(30, (self.height - kDeltaHeight) / 4 * 3, 80, self.height / 4);
    
    self.b9.frame = CGRectMake(self.width - self.height / 4 - 4 - 11, 0, self.height/ 4, self.height/ 4);
    
    self.b8.frame = CGRectMake(self.width - self.height / 4 - 4 - 11, self.height/ 4, self.height/ 4, self.height/ 4);
    
    self.b7.frame = CGRectMake(self.width - self.height / 4 - 4 - 11, self.height/ 4*2, self.height/ 4, self.height/ 4);
    
    self.b0.frame = CGRectMake(self.width - self.height / 4 - 4 - 11, self.height / 4*3, self.height/ 4, self.height/ 4);

    [self resetSelectedState];
    
    self.sepView.frame = CGRectMake(6, self.height - 0.5, self.width - 12, 0.5);
}

- (void)resetSelectedState
{
    switch ([MBSorter shared].currentDiscountSortModel.type) {
        case MBGoodsDiscount9:
            self.b9.selected = YES;
            self.b8.selected = NO;
            self.b7.selected = NO;
            self.b0.selected = NO;
            break;
        case MBGoodsDiscount8:
            self.b9.selected = NO;
            self.b8.selected = YES;
            self.b7.selected = NO;
            self.b0.selected = NO;
            break;
        case MBGoodsDiscount7:
            self.b9.selected = NO;
            self.b8.selected = NO;
            self.b7.selected = YES;
            self.b0.selected = NO;
            break;
        case MBGoodsDiscount0:
            self.b9.selected = NO;
            self.b8.selected = NO;
            self.b7.selected = NO;
            self.b0.selected = YES;
            break;
        default:
            break;
    }
}

- (void)selectButton:(UIButton *)sender
{
    if (sender == self.b9) {
        [MBSorter shared].currentDiscountSortModel.type = MBGoodsDiscount9;
    }else if (sender == self.b8) {
        [MBSorter shared].currentDiscountSortModel.type = MBGoodsDiscount8;
    }else if (sender == self.b7) {
        [MBSorter shared].currentDiscountSortModel.type = MBGoodsDiscount7;
    }else if (sender == self.b0) {
        [MBSorter shared].currentDiscountSortModel.type = MBGoodsDiscount0;
    }
    [self resetSelectedState];
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 26 * 4 + kDeltaHeight;
}
@end
