//
//  MBProductCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBProductCell.h"
#import "MBProductModel.h"

@interface MBProductCell ()
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *loveCount;
@property (nonatomic, strong) UIButton *loveButton;
@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *detailImageView;

@end

@implementation MBProductCell

- (id)initWithFrame:(CGRect)frame type:(MBProductCellType)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self buildSubviews];
    }
    return self;
}

#pragma mark - margins

#define kImageTopMargin (5)
#define kImageBottomMargin (12)
#define kImageLeftMargin (5)
#define kImageRightMargin (5)

#define kNameHeight (14)
#define kPriceHeight (11)
#define kLoveCountHeight (12)

#define kLoveButtonWidth (25)
#define kLoveButtonHeight (21)

#define kNameBottomMargin (8)
#define kPriceBottomMargin (11)

#pragma mark - properties

- (UIImageView *)showImageView
{
    if (!_showImageView) {
        _showImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.backgroundColor = V_COLOR(67, 74, 84, 1.0);
            imageView;
        });
    }
    return _showImageView;
}

- (UILabel *)name
{
    if (!_name) {
        _name = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = kGoodsNameTextColor;
            label;
        });
    }
    return _name;
}

- (UILabel *)price
{
    if (!_price) {
        _price = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont boldSystemFontOfSize:11];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = kGoodsPriceTextColor;
            label;
        });
    }
    return _price;
}

- (UILabel *)loveCount
{
    if (!_loveCount) {
        _loveCount = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _loveCount;
}

- (UIButton *)loveButton
{
    if (!_loveButton) {
        _loveButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button;
        });
    }
    return _loveButton;
}

- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _whiteView;
}

#pragma mark - methods

- (void)buildSubviews
{
    if (self.type == MBProductCellTypeNormal || self.type == MBProductCellTypeWithoutLove) {
        [self addSubview:self.showImageView];
        [self addSubview:self.whiteView];
        if (self.type == MBProductCellTypeNormal) {
            [self addSubview:self.loveButton];
            [self addSubview:self.loveCount];
        }
        [self.whiteView addSubview:self.name];
        [self.whiteView addSubview:self.price];
    }else{

        [self addSubview:self.showImageView];

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
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    if (self.type == MBProductCellTypeNormal || self.type == MBProductCellTypeWithoutLove) {
        self.showImageView.image = nil;
        self.name.text =
        self.price.text =
        self.loveCount.text = nil;
        self.showImageView.frame =
        self.loveCount.frame =
        self.name.frame =
        self.price.frame = CGRectZero;
        self.object = nil;
    }else{
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.object) {
        MBProductModel *model = self.object;
        if (self.type == MBProductCellTypeNormal || self.type == MBProductCellTypeWithoutLove) {
            
            self.showImageView.frame = CGRectMake(0, 0, self.width, self.height - 50);
            [self.showImageView setImageWithURL:[NSURL URLWithString:model.smallPicture] placeholderImage:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            self.whiteView.frame = CGRectMake(self.showImageView.left, self.height - 49, self.showImageView.width, 49);
            self.whiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
            
            self.name.frame = CGRectMake(11, 9.5, self.showImageView.width, kNameHeight);
            self.name.text = model.goodName;
            
            self.price.frame = CGRectMake(9, self.name.bottom + 5, self.width - 18, kPriceHeight);
            self.price.text = [@"￥" stringByAppendingFormat:@"%@",model.currentPrice];
            
            if (self.type == MBProductCellTypeNormal) {                
                self.loveButton.frame = CGRectMake(self.width - kLoveButtonWidth - 9, self.height - 77, kLoveButtonWidth, kLoveButtonHeight);
                [self.loveButton addTarget:self action:@selector(addCollecte) forControlEvents:UIControlEventTouchUpInside];
                if (model.isCollect) {
                    [self.loveButton setBackgroundImage:[UIImage imageNamed:@"ProductLikeClicked"] forState:UIControlStateNormal];
                    self.loveCount.textColor = [UIColor whiteColor];
                }else{
                    self.loveCount.textColor = [UIColor colorWithHexString:@"#434a54"];
                    [self.loveButton setBackgroundImage:[UIImage imageNamed:@"ProductLike"] forState:UIControlStateNormal];
                }
                self.loveCount.frame = CGRectMake(CGRectGetMinX(self.loveButton.frame) - 25, CGRectGetMinY(self.name.frame), 25, kLoveCountHeight);
                self.loveCount.backgroundColor = [UIColor clearColor];
                self.loveCount.center = self.loveButton.center;
                self.loveCount.text = [NSString stringWithFormat:@"%d",model.collectCount];
            }
            
            
        }else{
            self.showImageView.frame = CGRectMake(4.5, 4.5, self.width - 9, 151);
            [self.showImageView setImageWithURL:[NSURL URLWithString:[model smallPicture]] placeholderImage:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.showImageView.backgroundColor = [UIColor colorWithHexString:@"#434a54"];
            
            self.whiteView.frame = CGRectMake(self.showImageView.left, self.height - 51, self.showImageView.width, 51);
            
            CGSize size = BT_TEXTSIZE(model.goodName, [UIFont systemFontOfSize:14]);
            self.nameLabel.frame = CGRectMake(12, 16, size.width, size.height);
            self.nameLabel.text = model.goodName;
            
            size = BT_TEXTSIZE(([NSString stringWithFormat:@"￥%@",model.currentPrice]), [UIFont boldSystemFontOfSize:15]);
            self.priceLabel.frame = CGRectMake(self.nameLabel.right + 10, self.nameLabel.top, size.width, size.height);
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.currentPrice];
            
            self.detailImageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"Home" imageName:@"ProductShowDetail"];
            self.detailImageView.frame = CGRectMake(self.width - 20 - 19, 15, 19, 19);
        }
    }
}

- (void)addCollecte
{
    if (self.collecteGoodsBlock) {
        self.collecteGoodsBlock(self.object);
    }
}

#pragma mark - date

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    return columnWidth / 4.0 * 3.0 + 50;
}

@end
