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

@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *smallImageView;

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
#define kImageBottomMargin (5)
#define kImageLeftMargin (5)
#define kImageRightMargin (5)

#define kNameHeight (15)
#define kPriceHeight (13)
#define kLoveCountHeight (12)

#define kLoveButtonWidth (20)
#define kLoveButtonHeight (20)

#define kNameBottomMargin (5)
#define kPriceBottomMargin (5)

#pragma mark - properties

- (UIImageView *)showImageView
{
    if (!_showImageView) {
        _showImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
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
            label.textAlignment = NSTextAlignmentRight;
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

- (UIImageView *)bigImageView
{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _bigImageView;
}

- (UIImageView *)smallImageView
{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _smallImageView;
}

#pragma mark - methods

- (void)buildSubviews
{
    if (self.type == MBProductCellTypeNormal) {
        [self addSubview:self.showImageView];
        [self addSubview:self.name];
        [self addSubview:self.price];
        [self addSubview:self.loveCount];
        [self addSubview:self.loveButton];
    }else{
        [self addSubview:self.bigImageView];
        [self addSubview:self.smallImageView];
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    if (self.type == MBProductCellTypeNormal) {
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
        self.bigImageView.image = nil;
        self.smallImageView.image = nil;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.object) {
        MBProductModel *model = self.object;
        if (self.type == MBProductCellTypeNormal) {
            CGFloat imageWidth = self.width - kImageLeftMargin - kImageRightMargin;
            self.showImageView.frame = CGRectMake(kImageLeftMargin, kImageTopMargin, imageWidth, model.imageHeight / model.imageWidth * imageWidth);
            [self.showImageView setImageWithURL:[NSURL URLWithString:model.smallPicture] placeholderImage:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.name.frame = CGRectMake(self.showImageView.left, self.showImageView.bottom + kImageBottomMargin, self.showImageView.width - 50, kNameHeight);
            self.name.text = model.goodName;
            self.price.frame = CGRectMake(self.showImageView.left, self.name.bottom + kNameBottomMargin, self.name.width, kPriceHeight);
            self.price.text = [@"$" stringByAppendingFormat:@"%0ld",model.currentPrice];
            
            self.loveButton.frame = CGRectMake(CGRectGetMaxX(self.showImageView.frame) - kLoveButtonWidth, CGRectGetMinY(self.name.frame), kLoveButtonWidth, kLoveButtonHeight);
            [self.loveButton addTarget:self action:@selector(addCollecte) forControlEvents:UIControlEventTouchUpInside];
            self.loveButton.backgroundColor = [UIColor lightGrayColor];
            
            self.loveCount.frame = CGRectMake(CGRectGetMinX(self.loveButton.frame) - 25, CGRectGetMinY(self.name.frame), 25, kLoveCountHeight);
            self.loveCount.text = [NSString stringWithFormat:@"%d",model.collectCount];
        }else{
            self.bigImageView.frame = self.bounds;
            self.smallImageView.frame = CGRectMake(self.width - 100, self.height - 100, 100, 100);
            self.bigImageView.backgroundColor = [UIColor redColor];
            self.smallImageView.backgroundColor = [UIColor lightGrayColor];
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
    MBProductModel *model = object;
    CGFloat imageWidth = columnWidth - kImageLeftMargin - kImageRightMargin;
    return kImageTopMargin + model.imageHeight / model.imageWidth * imageWidth + kImageBottomMargin + kNameHeight + kNameBottomMargin + kPriceHeight + kPriceBottomMargin;
}

@end
