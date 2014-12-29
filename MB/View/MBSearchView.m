//
//  MBSearchView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchView.h"

@interface MBSearchView ()
@property (nonatomic, strong) DWTagList *tagList;
@end

@implementation MBSearchView

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)array image:(UIImage *)image
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        if (image) {
            self.image = image;
            DLog(@"%@,%@",NSStringFromCGSize(image.size),NSStringFromCGRect(frame));
        }
        self.backgroundColor = [UIColor clearColor];
//        if (kiOS7) {
//            self.toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
//        }else{
//        }
        self.toolBar = [[UIView alloc] initWithFrame:self.bounds];
        self.toolBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.toolBar];
        _tagList = [[DWTagList alloc] initWithFrame:CGRectMake((self.width - 230)/2.0, 20, 230,self.height - 20)];
        _tagList.font = [UIFont systemFontOfSize:15];
        _tagList.backgroundColor = [UIColor clearColor];
        _tagList.bottomMargin = 10.0;
        _tagList.labelMargin = 25;
        [_tagList setTags:array];
        _tagList.minimumWidth = 95;
        _tagList.horizontalPadding = 3;
        [_tagList setTagDelegate:self];
        [_tagList setTagBackgroundColor:kSearchKeyBackgroundColor];
        [_tagList setTagHighlightColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.3]];
        [_tagList setTextShadowOffset:CGSizeMake(0, 0)];
        [_tagList setCornerRadius:9.0f];
        [_tagList setBorderWidth:0.f];
        [_tagList setTextColor:[UIColor whiteColor]];
        [self addSubview:_tagList];
    }
    return self;
}

- (void)resetTags:(NSArray *)array
{
    [_tagList setTags:array];
}

- (void)selectedTag:(NSString *)tagName tagIndex:(NSInteger)tagIndex
{
    if (self.tagTapAction) {
        self.tagTapAction(tagName,tagIndex);
    }
}

@end
