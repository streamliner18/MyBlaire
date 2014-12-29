//
//  MBHomePageViewCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/13.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBHomePageViewCell.h"
#import "MBHomePageCellModel.h"
#import "MBHomePageCellNewModel.h"

@interface MBHomePageViewCell ()
@property (nonatomic, strong) UIImageView *showImageView;
@end

@implementation MBHomePageViewCell

#define kShowImageViewTopMargin (5)
#define kShowImageViewBottomMargin (5)
#define kShowImageViewLeftMargin (5)
#define kShowImageViewRightMargin (5)

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.showImageView = ({
            UIImageView*imageView =[[UIImageView alloc] initWithFrame:CGRectZero];
            imageView;
        });
        [self addSubview:self.showImageView];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.showImageView.image = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model) {
        MBHomePageCellModel *model = self.model;
        self.showImageView.image = [UIImage imageNamed:model.imageName];
        self.showImageView.frame = CGRectMake(kShowImageViewLeftMargin, kShowImageViewTopMargin, self.width - kShowImageViewLeftMargin - kShowImageViewRightMargin, self.height - kShowImageViewTopMargin - kShowImageViewBottomMargin);
    }
}


@end
