//
//  MBOperationView.m
//  MB
//
//  Created by Tongtong Xu on 14/11/12.
//  Copyright (c) 2014年 xxx Innovation Co. Ltd. All rights reserved.
//

#import "MBOperationView.h"

@implementation MBOperationView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(operationView:hitTest:withEvent:)]) {
        id object = [_delegate operationView:self hitTest:point withEvent:event];
        if (object != nil && [object isKindOfClass:[UIView class]]) {
            return object;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
