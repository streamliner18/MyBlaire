//
//  MBSortColorCell.m
//  MB
//
//  Created by Tongtong Xu on 14/11/28.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSortColorCell.h"
#import "MBSorter.h"

@interface MBSortColorCell ()
@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, strong) UIView *sepView;
@end

@implementation MBSortColorCell
- (UIView *)sepView
{
    if (!_sepView) {
        _sepView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
            view;
        });
    }
    return _sepView;
}

- (void)buildSubviews
{
    NSArray *colors = @[
                        @"#ee2727",
                        @"#f992d8",
                        @"#ff733c",
                        @"#f5f349",
                        @"#7534b8",
                        @"#007cfb",
                        @"#0d7119",
                        @"#4f4408",
                        @"#ffffff",
                        @"#000000",
                        @"#6b6b6b",
                        @"#b8ae79"
                        ];
    
    NSMutableArray *array = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(28 + j * (20 + 25),5 + i * 34, 20, 20)];
            imageView.backgroundColor = [UIColor colorWithHexString:colors[j+i*4]];
            imageView.layer.cornerRadius = 10;
            imageView.userInteractionEnabled = YES;
            UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, 22, 22)];
            circle.layer.borderWidth = 1;
            circle.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
            circle.layer.cornerRadius = 11;
            [imageView addSubview:circle];
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
            [self addSubview:imageView];
            [array addObject:imageView];
        }
    }
    self.imageViews = [NSArray arrayWithArray:array];
}

- (void)setCircleImageView:(UIImageView *)imageView state:(BOOL)selected
{
    if (selected) {
        imageView.frame = CGRectMake(-3, -3, 26, 26);
        imageView.layer.borderWidth = 3;
        imageView.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
        imageView.layer.cornerRadius = 13;
    }else{
        imageView.frame = CGRectMake(-1, -1, 22, 22);
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = V_COLOR(204, 204, 204, 1.0).CGColor;
        imageView.layer.cornerRadius = 11;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIImageView *view in self.imageViews) {
        if ([self.imageViews indexOfObject:view] == [MBSorter shared].currentColorSortModel.type) {
            [self setCircleImageView:[view.subviews firstObject] state:YES];
        }else{
            [self setCircleImageView:[view.subviews firstObject] state:NO];
        }
    }
    self.sepView.frame = CGRectMake(6, self.height - 0.5, self.width - 12, 0.5);
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    for (UIImageView *view in self.imageViews) {
        if (view == sender.view) {
            [self setCircleImageView:[view.subviews firstObject] state:YES];
            [MBSorter shared].currentColorSortModel.type = [self.imageViews indexOfObject:view];
        }else{
            [self setCircleImageView:[view.subviews firstObject] state:NO];
        }
    }
}

+ (CGFloat)cellHeightWithModel:(id)model
{
    return 120;
}
@end
