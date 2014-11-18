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

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)array
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        if (iOS7) {
            self.toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        }else{
            self.toolBar = [[UIView alloc] initWithFrame:self.bounds];
            self.toolBar.backgroundColor = [UIColor whiteColor];
        }
        [self addSubview:self.toolBar];
        _tagList = [[DWTagList alloc] initWithFrame:CGRectMake(10, 20, self.width-20,self.height - 20)];
        _tagList.font = [UIFont systemFontOfSize:15];
        _tagList.backgroundColor = [UIColor clearColor];
        _tagList.bottomMargin = 10.0;
        [_tagList setTags:array];
        _tagList.minimumWidth = (_tagList.width - 54) / 3.0;
        _tagList.verticalPadding = 3;
        [_tagList setTagDelegate:self];
        [_tagList setTagBackgroundColor:[UIColor clearColor]];
        [_tagList setTagHighlightColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.3]];
        [_tagList setTextShadowOffset:CGSizeMake(0, 0)];
        [_tagList setCornerRadius:2.0f];
        [_tagList setBorderWidth:0.f];
        [_tagList setTextColor:[UIColor blackColor]];
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
