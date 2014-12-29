//
//  BT_XTPageControl.h
//  PagedScrollView
//
//  Created by Tongtong Xu on 14-10-13.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BT_XTPageControlDelegate <NSObject>

@optional

- (void)pageControlDidStopAtIndex:(NSInteger)index;

@end

@interface BT_XTPageControl : UIView
{
    UIImage         *_normalDotImage;
    UIImage         *_highlightedDotImage;
    float           __dotsSize;
    NSInteger       __dotsGap;
}

@property (nonatomic) NSInteger pageNumbers;
@property (nonatomic , weak) id<BT_XTPageControlDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
        normalImage:(UIImage *)nImage
   highlightedImage:(UIImage *)hImage
         dotsNumber:(NSInteger)pageNum
         sideLength:(NSInteger)size
            dotsGap:(NSInteger)gap;

- (void)setCurrentPage:(NSInteger)pages;
@end
