//
//  MBSearchView.h
//  MB
//
//  Created by Tongtong Xu on 14/11/14.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DWTagList.h>

typedef void(^MBSearchViewTagSearchBlock)(NSString *tag,NSInteger index);

@interface MBSearchView : UIView<DWTagListDelegate>

@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, copy) MBSearchViewTagSearchBlock tagTapAction;

- (instancetype)initWithFrame:(CGRect)frame tags:(NSArray *)array;

- (void)resetTags:(NSArray *)array;

@end
