//
//  MBHomePageViewDiscountCell.m
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageViewDiscountCell.h"
#import "MBHomePageCellNewModel.h"
#import "BT_XTCycleScrollView.h"

@interface MBHomePageViewDiscountCell ()
@property (nonatomic, strong) BT_XTCycleScrollView *scrollView;
@end

@implementation MBHomePageViewDiscountCell

- (void)buildSubviews
{
    self.scrollView = [[BT_XTCycleScrollView alloc] initWithFrame:CGRectMake(4.5, 0, [[[UIApplication sharedApplication] keyWindow] frame].size.width - 9, 139.5) animationDuration:3];
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MBHomePageCellNewModelDiscount *discount = self.model;
    if (discount) {
        __weak typeof(self) weakSelf = self;
        self.scrollView.totalPagesCount = ^NSInteger(void){
            return discount.discountProducts.count;
        };
        self.scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            MBProductModel *model = [discount.discountProducts objectAtIndex:pageIndex];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:weakSelf.scrollView.bounds];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageSlideshow] placeholderImage:nil options:0 progress:nil completed:nil];
            //imageView.backgroundColor = [UIColor colorWithHexString:@"#e2e4ec"];
            imageView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 89, imageView.width, 50.5)];
            whiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            [imageView addSubview:whiteView];
            
            UILabel *label = ({
                UILabel *label = [[UILabel alloc] initWithFrame:whiteView.frame];
                label.font = [UIFont systemFontOfSize:15];
                label.text = model.goodName;
                label.textColor = V_COLOR(67, 74, 81, 1.0);
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentCenter;
                label;
            });
            [imageView addSubview:label];
            return imageView;
        };
        
        @weakify(self);
        self.scrollView.TapActionBlock = ^(NSInteger pageIndex){
            @strongify(self);
            if (self.tapBlock) {
                self.tapBlock([discount.discountProducts objectAtIndex:pageIndex]);
            }
        };
    }
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 139.5;
}

@end
