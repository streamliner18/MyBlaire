//
//  MBHomePageViewPopularCell.m
//  MB
//
//  Created by Tongtong Xu on 14/12/1.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageViewPopularCell.h"
#import "MBHomePageCellNewModel.h"
#import "TTXMessageHUD.h"

@interface MBHomePageViewPopularCell ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MBHomePageViewPopularCell
- (void)buildSubviews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.clipsToBounds = NO;
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    MBHomePageCellNewModelPopular *popular = self.model;
    if (popular) {
        
        self.scrollView.frame = CGRectMake(4.5, 5, self.width-9, self.height-5);
        self.scrollView.contentSize = CGSizeMake(popular.popularProducts.count * (145 + 4.5) - 4.5, self.height-5);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [popular.popularProducts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            MBProductModel *model = obj;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((145+4.5)*idx, 0, 145, 85)];
            imageView.tag = idx + 100;
            //imageView.backgroundColor = [UIColor colorWithHexString:@"#434a54"];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageTrending] placeholderImage:nil];
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedGoods:)]];
            [self.scrollView addSubview:imageView];
            UIImageView *heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.width -31, 8, 23, 19)];
            heartImageView.userInteractionEnabled = YES;
            [heartImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addToCollection:)]];
            [imageView addSubview:heartImageView];
            UILabel *countLabel = [[UILabel alloc] initWithFrame:heartImageView.frame];
            countLabel.tag = 2;
//            countLabel.textColor = [UIColor colorWithHexString:@"#434a54"];
            countLabel.font = [UIFont systemFontOfSize:10];
            countLabel.textAlignment = NSTextAlignmentCenter;
            countLabel.text = [NSString stringWithFormat:@"%d",model.collectCount];
            [imageView addSubview:countLabel];
            
            if (model.isCollect) {
                countLabel.textColor = [UIColor whiteColor];
                heartImageView.image = [UIImage imageNamed:@"ProductLikeClicked"];
            }else{
                heartImageView.image = [UIImage imageNamed:@"ProductLike"];
                countLabel.textColor = [UIColor colorWithHexString:@"#434a54"];
            }
        }];
    }
}

- (void)addToCollection:(UITapGestureRecognizer *)sender
{
    MBHomePageCellNewModelPopular *popular = self.model;

    MBProductModel *model = [popular.popularProducts objectAtIndex:sender.view.superview.tag - 100];
    
    [MBSta staWithType:MBStaTypeClickCollecte param:model.goodId];
    [MBApi collecteGoods:model.goodId collecteState:model.isCollect?@"1":@"0" completionHandle:^(MBApiError *error) {
        if (error.code == MBApiCodeSuccess) {
            if (model.isCollect) {
                [TTXMessageHUD showMessageHUDWithMessage:@"取消收藏"];
                model.collectCount--;
                [(UIImageView *)sender.view setImage:[UIImage imageNamed:@"ProductLike"]];
            }else{
                model.collectCount++;
                [TTXMessageHUD showMessageHUDWithMessage:@"已收藏到心愿单"];
                [(UIImageView *)sender.view setImage:[UIImage imageNamed:@"ProductLikeClicked"]];
            }
            UILabel *label = (UILabel *)[sender.view.superview viewWithTag:2];
            label.text = [NSString stringWithFormat:@"%d",model.collectCount];
            if (model.isCollect) {
                label.textColor = [UIColor colorWithHexString:@"#434a54"];
            }else{
                label.textColor = [UIColor whiteColor];
            }
            model.isCollect = !model.isCollect;
        }else{
            [TTXMessageHUD showMessageHUDWithMessage:error.message];
        }
    }];
}

- (void)didSelectedGoods:(UITapGestureRecognizer *)sender
{
    MBHomePageCellNewModelPopular *popular = self.model;
    if (popular) {
        if (self.tapBlock) {
            self.tapBlock([popular.popularProducts objectAtIndex:sender.view.tag - 100]);
        }
    }
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 85+5;
}

@end
