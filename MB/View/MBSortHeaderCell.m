//
//  MBSortHeaderCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/28.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortHeaderCell.h"
#import "MBSortModel.h"

@interface MBSortHeaderCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selecteButton;
@property (nonatomic, strong) UIView *sepView;
@end

@implementation MBSortHeaderCell

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor colorWithHexString:@"#525a66"];
            label;
        });
    }
    return _titleLabel;
}

- (UIButton *)selecteButton
{
    if (!_selecteButton) {
        _selecteButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 21, 21);
            button.userInteractionEnabled = NO;
            [button setImage:[UIImage bt_imageWithBundleName:@"Source" filepath:@"Sort" imageName:@"ExpandButton"] forState:UIControlStateNormal];
            button;
        });
    }
    return _selecteButton;
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
    [self addSubview:self.titleLabel];
    [self addSubview:self.selecteButton];
    [self addSubview:self.sepView];
//    self.selectedBackgroundView = [UIView viewWithColor:UIColorFromRGB(0xF2F2F2)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    MBSortModel *model = self.model;
    if (model) {
        self.titleLabel.frame = CGRectMake(21, 16, 120, 18);
        self.titleLabel.text = model.title;
        self.selecteButton.frame = CGRectMake(self.width - 21 - 21, 12, 21, 21);
        if (model.isOpen) {
            self.selecteButton.transform = CGAffineTransformIdentity;
            self.sepView.frame = CGRectZero;
        }else{
            self.selecteButton.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.sepView.frame = CGRectMake(6, self.height - 0.5, self.width - 12, 0.5);
        }
    }
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 45;
}

@end
