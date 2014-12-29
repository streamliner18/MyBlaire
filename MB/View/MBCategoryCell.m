//
//  MBCategoryCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/27.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBCategoryCell.h"
#import "MBCategoryModel.h"

@interface MBCategoryCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation MBCategoryCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView;
        });
        [self addSubview:self.imageView];
        self.nameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label;
        });
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    MBCategoryModel *model = self.object;
    if (model) {
        self.imageView.frame = CGRectMake(self.width / 320.0 * 60, self.height / 336.0 * 60, self.width / 320.0 * 200, self.width / 320.0 * 200);
        self.imageView.image = [UIImage bt_imageWithBundleName:@"Source" filepath:@"CategoryBags" imageName:model.imageName];
        self.imageView.layer.cornerRadius = 50;
        self.nameLabel.text = model.name;
        self.nameLabel.frame = CGRectMake(0, self.imageView.bottom, self.width, self.height - self.imageView.bottom);
    }
}

@end
