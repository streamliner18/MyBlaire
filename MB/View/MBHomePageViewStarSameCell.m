//
//  MBHomePageViewStarSameCell.m
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageViewStarSameCell.h"
#import "MBHomePageCellNewModel.h"

@interface MBHomePageViewStarSameCell ()
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *detailImageView;
@end

@implementation MBHomePageViewStarSameCell

- (void)buildSubviews
{
    self.showImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView;
    });
    [self addSubview:self.showImageView];
    
    self.whiteView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:self.whiteView];
    
    self.nameLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor colorWithHexString:@"#434a54"];
        label.font = [UIFont systemFontOfSize:14];
        label;
    });
    [self.whiteView addSubview:self.nameLabel];
    
    self.priceLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor colorWithHexString:@"#434a54"];
        label.font = [UIFont boldSystemFontOfSize:15];
        label;
    });
    [self.whiteView addSubview:self.priceLabel];
    
    self.detailImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView;
    });
    [self.whiteView addSubview:self.detailImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MBHomePageCellNewModelStarSame *starSame = self.model;
    if (starSame) {
        self.showImageView.frame = CGRectMake(4.5, 4.5, self.width - 9, 151);
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:starSame.product.imageHighlight] placeholderImage:nil];
        self.showImageView.backgroundColor = [UIColor colorWithHexString:@"#434a54"];
        
        self.whiteView.frame = CGRectMake(self.showImageView.left, self.height - 51, self.showImageView.width, 51);
        
        CGSize size = BT_TEXTSIZE(starSame.product.goodName, [UIFont systemFontOfSize:14]);
        self.nameLabel.frame = CGRectMake(12, 16, size.width, size.height);
        self.nameLabel.text = starSame.product.goodName;
        
        size = BT_TEXTSIZE(([NSString stringWithFormat:@"￥%@",starSame.product.currentPrice]), [UIFont boldSystemFontOfSize:15]);
        self.priceLabel.frame = CGRectMake(self.nameLabel.right + 10, self.nameLabel.top, size.width, size.height);
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",starSame.product.currentPrice];
        
        self.detailImageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Home" imageName:@"ProductShowDetail"];
        self.detailImageView.frame = CGRectMake(self.width - 20 - 19, 15, 19, 19);
    }
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 151 + 4.5;
}

@end
