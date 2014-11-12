//
//  MBOperationView.h
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBOperationView;

@protocol MBOperationViewDelegate <NSObject>

- (UIView *)operationView:(MBOperationView *)operationView hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end

@interface MBOperationView : UIView
@property (nonatomic,weak) id <MBOperationViewDelegate> delegate;
@end
