//
//  MBSearchView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBSearchView.h"

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
        DWTagList *tagList = [[DWTagList alloc] initWithFrame:CGRectMake(10, 20, self.width-20,self.height - 20)];
        tagList.font = [UIFont systemFontOfSize:15];
        tagList.backgroundColor = [UIColor clearColor];
        tagList.bottomMargin = 10.0;
        [tagList setTags:array];
        tagList.minimumWidth = (tagList.width - 54) / 3.0;
        tagList.verticalPadding = 3;
        [tagList setTagDelegate:self];
        [tagList setTagBackgroundColor:[UIColor clearColor]];
        [tagList setTagHighlightColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.3]];
        [tagList setTextShadowOffset:CGSizeMake(0, 0)];
        [tagList setCornerRadius:2.0f];
        [tagList setBorderWidth:0.f];
        [tagList setTextColor:[UIColor blackColor]];
        [self addSubview:tagList];
    }
    return self;
}

- (void)selectedTag:(NSString *)tagName tagIndex:(NSInteger)tagIndex
{
    if (self.tagTapAction) {
        self.tagTapAction(tagName,tagIndex);
    }
}

@end
