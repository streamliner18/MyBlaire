//
//  BT_XTPageControl.m
//  PagedScrollView
//
//  Created by Tongtong Xu on 14-10-13.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "BT_XTPageControl.h"

@interface BT_XTPageControl ()
@property (nonatomic , strong)UIImage *normalDotImage;
@property (nonatomic , strong)UIImage *highlightedDotImage;
@property (nonatomic , strong)NSMutableArray *dotsArray;
@property (nonatomic , assign)float dotsSize;
@property (nonatomic , assign)NSInteger dotsGap;
@property (nonatomic , retain) UIImageView *highlightedDotImageView;
- (void)dotsDidTouched:(UIView *)sender;
@end

@implementation BT_XTPageControl

- (id)initWithFrame:(CGRect)frame
        normalImage:(UIImage *)nImage
   highlightedImage:(UIImage *)hImage
         dotsNumber:(NSInteger)pageNum
         sideLength:(NSInteger)size
            dotsGap:(NSInteger)gap
{
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        self.dotsGap = gap;
        self.dotsSize = size;
        self.dotsArray = [NSMutableArray array];
        self.normalDotImage = nImage;
        self.highlightedDotImage = hImage;
        self.pageNumbers = pageNum;
        
        UIImageView *dotImageView_h = [[UIImageView alloc] initWithImage:_highlightedDotImage];
        [dotImageView_h.layer setMasksToBounds:YES];
        dotImageView_h.layer.cornerRadius = self.dotsSize / 2.0;
        dotImageView_h.frame = CGRectMake(0, 0, self.dotsSize, self.dotsSize);
        self.highlightedDotImageView = dotImageView_h;

        for (int i = 0; i != _pageNumbers; ++ i) {
            UIImageView *dotsImageView = [[UIImageView alloc] init];
            dotsImageView.userInteractionEnabled = YES;
            dotsImageView.frame = CGRectMake((size + gap) * i, 0, size, size);
            dotsImageView.tag = 100 + i;
            if (i == 0) {
                self.highlightedDotImageView.frame = CGRectMake((size + gap) * i, 0, size, size);
            }
            dotsImageView.image = _normalDotImage;
            [dotsImageView.layer setMasksToBounds:YES];
            dotsImageView.layer.cornerRadius = size / 2.0;
            
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dotsDidTouched:)];
            [dotsImageView addGestureRecognizer:gestureRecognizer];
            [self addSubview:dotsImageView];
        }
        [self addSubview:_highlightedDotImageView];
    }
    return self;
}

- (void)dotsDidTouched:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pageControlDidStopAtIndex:)]) {
        [_delegate pageControlDidStopAtIndex:[[sender view] tag] - 100];
    }
}

- (void)setCurrentPage:(NSInteger)pages
{
    if (_normalDotImage || _highlightedDotImage) {
        CGRect newRect = CGRectMake((self.dotsSize + self.dotsGap) * pages, 0, self.dotsSize, self.dotsSize);
        self.highlightedDotImageView.frame = newRect;
//        [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
//        } completion:^(BOOL finished){}];
    }
}


@end
