//
//  MBGoodsImagesView.m
//  MB
//
//  Created by xt-work on 14/11/20.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBGoodsImagesView.h"
#import "MBProductModel.h"
#import <iCarousel.h>

@interface MBGoodsImagesView ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic, strong) iCarousel *carousel;
@end

@implementation MBGoodsImagesView

- (iCarousel *)carousel
{
    if (!_carousel) {
        _carousel = [[iCarousel alloc] initWithFrame:self.bounds];
        _carousel.type = iCarouselTypeLinear;
        _carousel.pagingEnabled = YES;
    }
    return _carousel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}
#define kImageTopMargin (10)
#define kImageLeftMargin (10)
#define kImageRightMargin (10)
#define kImageHeight (300)


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (!view){
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kImageLeftMargin, kImageTopMargin, view.width - kImageLeftMargin - kImageRightMargin, kImageHeight)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag = 1;
        [view addSubview:imageView];
    }else{
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    NSString *imageURL = nil;
    switch (index) {
        case 0:
            imageURL = self.model.bigPctureUrl;
            imageView.backgroundColor = [UIColor redColor];
            break;
        case 1:
            imageURL = self.model.bigPctureUrl2;
            imageView.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            imageURL = self.model.bigPctureUrl3;
            imageView.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    if (imageURL) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    
    return view;
}


@end
